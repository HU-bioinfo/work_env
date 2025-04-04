import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed

export function activate(context: vscode.ExtensionContext) {
    const extensionStoragePath = context.globalStorageUri.fsPath;
    const devcontainerPath = path.join(extensionStoragePath, ".devcontainer");
    const dockercomposeFilePath = path.join(devcontainerPath, "docker-compose.yml");

    let startWorkEnvCommand = vscode.commands.registerCommand('work-env.start-work-env', async () => {
        try{
            // docker imageの更新
            await vscode.commands.executeCommand("workbench.action.terminal.new");
            const terminal = vscode.window.activeTerminal;
            terminal?.sendText("docker pull kokeh/hu_bioinfo:stable");
            
            // .devcontainer の設定
            if (!fs.existsSync(devcontainerPath)) {
                vscode.window.showInformationMessage("Setting up .devcontainer...");
                setupDevContainer(context, devcontainerPath);
            }
            
            if (!fs.existsSync(dockercomposeFilePath)) {
                const success = await generateDockerCompose(context, dockercomposeFilePath);
                if (!success) return;
            }

            // remote-containers.openFolder コマンドで開く
            openFolderInContainer(extensionStoragePath)
        } catch (error) {
            vscode.window.showErrorMessage(`Error: ${error}`);
        }
    });
    
    
    let resetConfigCommand = vscode.commands.registerCommand('work-env.reset-config', async () => {
        try {
            await vscode.commands.executeCommand("workbench.action.terminal.new");
            const terminal = vscode.window.activeTerminal;
            terminal?.sendText("docker pull kokeh/hu_bioinfo:stable");

            if (!fs.existsSync(devcontainerPath)) {
                vscode.window.showInformationMessage("First, run 'Start work-env'");
                return;
            }

            // ここで false が返ったら処理を中断
            const success = await generateDockerCompose(context, dockercomposeFilePath);
            if (!success) return;

            // 一度現在存在しているこのextension用のdocker containerを削除
            terminal?.sendText("docker rm -f $(docker ps -aq --filter 'name=hu-bioinfo-workshop' --filter 'name=work-env')");
            
            // remote-containers.openFolder コマンドで開く
            openFolderInContainer(extensionStoragePath)
        } catch (error) {
            vscode.window.showErrorMessage(`Error: ${error}`);
        }
    });


    context.subscriptions.push(startWorkEnvCommand);
    context.subscriptions.push(resetConfigCommand);
}

// This method is called when your extension is deactivated
export function deactivate() {}

function setupDevContainer(context: vscode.ExtensionContext, targetPath: string) {
    const sourcePath = path.join(context.extensionUri.fsPath, ".devcontainer");
    copyFolderRecursiveSync(sourcePath, targetPath);
}

function openFolderInContainer(extensionStoragePath: string) {
    const folderUri = vscode.Uri.file(extensionStoragePath)
    vscode.commands.executeCommand("remote-containers.openFolder", folderUri).
    then(() => {
    }, (error) => {
        vscode.window.showErrorMessage(`Failed to open folder in container: ${error.message}`);
    });
}

async function generateDockerCompose(context: vscode.ExtensionContext, dockercomposeFilePath: string) {
    const dockercomposeTempletePath = path.join(context.extensionUri.fsPath, "docker-compose.templete.yml");
    // プロジェクトフォルダの選択
    const projectFolderUri = await vscode.window.showOpenDialog({
        canSelectFolders: true,
        canSelectMany: false,
        openLabel: "Select Project Folder"
    });
    if (!projectFolderUri || projectFolderUri.length === 0) {
        vscode.window.showErrorMessage("No project folder selected.");
        return false;  // 失敗
    }
    const projectFolder = projectFolderUri[0].fsPath;

    // キャッシュディレクトリの選択
    const cacheFolderUri = await vscode.window.showOpenDialog({
        canSelectFolders: true,
        canSelectMany: false,
        openLabel: "Select Cache Folder"
    });
    if (!cacheFolderUri || cacheFolderUri.length === 0) {
        vscode.window.showErrorMessage("No cache folder selected.");
        return false;  // 失敗
    }
    const cacheFolder = cacheFolderUri[0].fsPath;

    // GitHub PAT の入力
    const githubPat = await vscode.window.showInputBox({
        prompt: "Enter your GitHub Personal Access Token",
        ignoreFocusOut: true,
        password: true
    });
    if (!githubPat) {
        vscode.window.showErrorMessage("GitHub PAT is required.");
        return false;  // 失敗
    }

    try{
        await vscode.commands.executeCommand("workbench.action.terminal.new");
        const terminal = vscode.window.activeTerminal;
        terminal?.sendText(`chmod 777 "${projectFolder}"`);
        terminal?.sendText(`chmod 777 "${cacheFolder}"`);
    } catch (error) {
        vscode.window.showErrorMessage("Permission occur: chmod folders.");
        return false;
    }

    try {
        const replacements: Record<string, string> = {
            GITHUB_PAT: githubPat,
            CACHE_FOLDER: cacheFolder,
            PROJECT_FOLDER: projectFolder
        };

        // テンプレートファイルを読み込む
        let template = fs.readFileSync(dockercomposeTempletePath, 'utf8');

        // プレースホルダーを置換
        Object.entries(replacements).forEach(([key, value]) => {
            const regex = new RegExp(`{{${key}}}`, 'g'); // `{{GITHUB_PAT}}` のようなパターンを探す
            template = template.replace(regex, value);
        });

        fs.writeFileSync(dockercomposeFilePath, template.trim());
        return true;  // 成功
    } catch (error) {
        vscode.window.showErrorMessage("Error generating docker-compose.yml.");
        return false;  // 失敗
    }
}

function copyFolderRecursiveSync(source: string, target: string) {
    if (!fs.existsSync(source)) return;
    if (!fs.existsSync(target)) fs.mkdirSync(target, { recursive: true });

    const files = fs.readdirSync(source);
    for (const file of files) {
        const srcPath = path.join(source, file);
        const destPath = path.join(target, file);
        if (fs.lstatSync(srcPath).isDirectory()) {
            copyFolderRecursiveSync(srcPath, destPath);
        } else {
            fs.copyFileSync(srcPath, destPath);
        }
    }
}