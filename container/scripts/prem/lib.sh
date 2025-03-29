#!/usr/bin/env bash

log_info() {
    echo -e "[INFO] $1"
}

log_error() {
    echo -e "[ERROR] $1" >&2
}

init() {
    local proj_name=$1
    local proj_path="$PROJ_DIR/$proj_name"
    if [ -d "$proj_path" ]; then
        log_error "Project $1 already exists."
        return 1
    fi

    if [ "$#" -gt 2 ]; then
        log_error "Too much arguments"
        echo $usage_msg
        return 1
    elif [ "$#" -eq 1 ]; then
        set_venv
        set_renv
    else
        local type=$2
        
        if [ "$type" = "-py" ]; then
            set_venv
        elif [ "$type" = "-r" ]; then 
            set_renv
        else
            log_error "Invalid option type"
            echo $usage_msg
            return 1
        fi
    fi


}

set_venv() {
    cd $PROJ_DIR
    uv init $proj_name
    cd $proj_path
    uv venv 
    
    mkdir -p $PREM_DIR/env/$proj_name
    mv $proj_path/.venv $PREM_DIR/env/$proj_name/.venv
    ln -s $PREM_DIR/env/$proj_name/.venv $proj_path/.venv
        echo "source $BASE_ENV_DIR/python/$python_env/.venv/bin/activate" >> "$proj_path/.envrc"

    rm main.py
    rm README.md
    
    mkdirs
}

set_renv() {
    mkdir -p $proj_path
    cd $proj_path
    Rscript -e 'library(renv)' -e 'renv::init()' -e 'q()' --no-save

    mkdir -p $PREM_DIR/env/$proj_name
    mv $proj_path/renv $PREM_DIR/env/$proj_name/renv
    ln -s $PREM_DIR/env/$proj_name/renv $proj_path/renv

    mkdirs
}

mkdirs() {
    mkdir -p codes
    mkdir -p data
    mkdir -p output

    cd $proj_path
}

list() {
    ls $PROJ_DIR -1
}

rm() {
    local proj_name=$1
    local proj_path="$PROJ_DIR/$proj_name"
    if [ -d "$proj_path" ]; then
        rm -rf "$PROJ_DIR/$proj_name"
        rm -rf "$PREM_DIR/env/$proj_name"
        log_info "Project $proj_name removed."
    else
        log_error "Project $proj_name does not exist."
        return 1
    fi
}

rm_all() {
    rm -rf $PROJ_DIR/*/
    rm -rf $PREM_DIR/env/*/
}

# 環境作成
mkenv() {
    
    local env_name=$1
    local usage_msg="Usage: mkenv env-name -py/-r"
    
    if [ "$#" -gt 2 ]; then
        log_error "Too much arguments"
        echo $usage_msg
        return 1
    elif [ "$#" -eq 1 ]; then
        mkenv_py $env_name
        mkenv_r $env_name
    else
        local type=$2
        
        if [ "$type" = "-py" ]; then
            mkenv_py $env_name
        elif [ "$type" = "-r" ]; then 
            mkenv_r $env_name
        else
            log_error "Invalid option type"
            echo $usage_msg
            return 1
        fi
    fi

    # if [ "$type" = "python" ]; then
    #     uv venv .venv
    #     echo 'layout python' > .envrc
    # elif [ "$type" = "r" ]; then
    #     Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv')"
    #     Rscript -e "renv::init()"
    #     echo 'source renv/activate.R' > .envrc
    #
    # direnv allow
    # log_info "Environment $env_name created in $env_path"
}

mkenv_py() {
    local env_name=$1
    local env_path="$PREM_DIR/env/venv/$env_name"
    if [ -d "$env_path" ]; then
        log_error "Python environment:$env_name already exists."
    else
        uv venv $env_path/.venv
    fi
}

mkenv_r() {
    local env_name=$1
    local env_path="$PREM_DIR/env/renv/$env_name"
    if [ -d "$env_path" ]; then
        log_error "R environment:$env_name already exists."
    else
        mkdir -p $env_path
        cd $env_path
        Rscript -e 'library(renv)' -e 'renv::init()' -e 'renv::activate()' -e 'q()' --no-save
        cd $PWD
    fi
}

# 環境削除
rmenv() {
    local env_name=$1
    local usage_msg="Usage: rmenv env-name -py/-r"
    
    if [ "$#" -gt 2 ]; then
        log_error "Too much arguments"
        echo $usage_msg
        return 1
    elif [ "$#" -eq 1 ]; then
        rmdir_c "$PREM_DIR/env/venv/$env_name"
        rmdir_c "$PREM_DIR/env/renv/$env_name"
    else
        local type=$2
        
        if [ "$type" = "-py" ]; then
            rmdir_c "$PREM_DIR/env/venv/$env_name"
        elif [ "$type" = "-r" ]; then 
            local env_path="$PREM_DIR/env/renv/$env_name"
            cd $env_path
            rmdir_c $(find "${PREM_DIR}/env/renv" -type d -name "${env_name}-????????")
            Rscript -e 'renv::deactivate()' -e 'renv::clean()' -e 'q()' --nosave
            cd $PWD
            rmdir_c $env_path
        else
            log_error "Invalid option type"
            echo $usage_msg
            return 1
        fi
    fi
}

rmdir_c() {
    local dirpath=$1
    if [ -d "$dirpath" ]; then
        rm -rf "$dirpath"
        log_info "$dirpath removed."
    else
        log_error "$dirpath does not exist."
    fi
}

# 環境設定
setenv() {
    local proj_path=$1
    shift 1

    local python_env=""
    local r_env=""
    local args=("$@")
    local i=0
    
    # 引数を2つずつに分割して処理
    while [ $i -lt ${#args[@]} ]; do
        local option=${args[$i]}
        
        # 次の引数が存在するか確認
        if [ $(($i + 1)) -lt ${#args[@]} ]; then
            local value=${args[$(($i + 1))]}
            
            case $option in
                -py) python_env=$value ;;
                -r) r_env=$value ;;
                *) log_error "Invalid option: $option"; return 1 ;;
            esac
            
            i=$(($i + 2))
        else
            # -pyや-rでない場合はエラーメッセージを表示
            if [[ "$option" != "-py" && "$option" != "-r" ]]; then
                log_error "Option: -py/-r"
                return 1
            else
                log_error "Option $option requires a value"
                return 1
            fi
        fi
    done
    
    # 環境変数の設定
    if [ -n "$python_env" ]; then
        local py_env_path="$PREM_DIR/env/venv/$python_env"
        if [ ! -d "$py_env_path" ]; then
            log_error "Python environment:$python_env does not exist."
            return 0
        else
            echo -e "source ${py_env_path}/.venv/bin/activate" >> $proj_path/.envrc
            echo -e "export VIRTUAL_ENV=${py_env_path}/.venv" >> $proj_path/.envrc
            echo -e "export PATH=\$VIRTUAL_ENV/bin:\$PATH" >> $proj_path/.envrc
            cd $proj_path
            direnv allow
            cd $PWD
        fi
    fi
    
    if [ -n "$r_env" ]; then
        local r_env_path="$PREM_DIR/env/renv/$r_env"
        if [ ! -d "$r_env_path" ]; then
            log_error "R environment:$r_env does not exist."
            return 0
        else
            echo "export RENV_PATHS_LIBRARY=${r_env_path}" > $proj_path/.envrc
        fi
    fi

}

# 連携プロジェクト確認
proj_list() {
    echo 1
}

comfirm_project_exist() {
    echo 1
}



################

# プロジェクト作成
mkproj() {
    local proj_name=$1
    local python_env=""
    local r_env=""
    shift

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -p) python_env=$2; shift 2;;
            -r) r_env=$2; shift 2;;
            *) log_error "Invalid option: $1"; return 1;;
        esac
    done
    
    if [ -z "$python_env" ] && [ -z "$r_env" ]; then
        log_error "At least one of -p or -r must be specified."
        return 1
    fi
    
    local proj_path="$BASE_PROJ_DIR/$proj_name"
    if [ -d "$proj_path" ]; then
        log_error "Project $proj_name already exists."
        return 1
    fi
    
    mkdir -p "$proj_path/data" "$proj_path/output" "$proj_path/codes"
    cd "$proj_path" || return 1
    
    if [ -n "$python_env" ]; then
        echo "source $BASE_ENV_DIR/python/$python_env/.venv/bin/activate" >> .envrc
    fi
    if [ -n "$r_env" ]; then
        echo "source $BASE_ENV_DIR/r/$r_env/renv/activate.R" >> .envrc
    fi
    
    direnv allow
    log_info "Project $proj_name created in $proj_path"
}

# プロジェクトの環境変更
setproj() {
    local proj_name=$1
    local python_env=""
    local r_env=""
    shift

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -p) python_env=$2; shift 2;;
            -r) r_env=$2; shift 2;;
            *) log_error "Invalid option: $1"; return 1;;
        esac
    done
    
    local proj_path="$BASE_PROJ_DIR/$proj_name"
    if [ ! -d "$proj_path" ]; then
        log_error "Project $proj_name does not exist."
        return 1
    fi
    
    echo "" > "$proj_path/.envrc"
    if [ -n "$python_env" ]; then
        echo "source $BASE_ENV_DIR/python/$python_env/.venv/bin/activate" >> "$proj_path/.envrc"
    fi
    if [ -n "$r_env" ]; then
        echo "source $BASE_ENV_DIR/r/$r_env/renv/activate.R" >> "$proj_path/.envrc"
    fi
    
    direnv allow "$proj_path"
    log_info "Project $proj_name updated with new environments."
}

# プロジェクト削除
rmproj() {
    local proj_name=$1
    local proj_path="$BASE_PROJ_DIR/$proj_name"
    
    if [ -d "$proj_path" ]; then
        rm -rf "$proj_path"
        log_info "Project $proj_name removed."
    else
        log_error "Project $proj_name does not exist."
        return 1
    fi
}