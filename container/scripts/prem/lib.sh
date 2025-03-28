#!/usr/bin/env bash

log_info() {
    echo -e "[INFO] $1"
}

log_error() {
    echo -e "[ERROR] $1" >&2
}

# 環境作成
mkenv() {
    local env_name=$1
    local usage_msg="Usage: mkenv env-name -py/-r"
    
    if [ "$#" -gt 2 ]; then
        log_error "Too much arguments"
        echo $usage_msg
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
        fi
    fi

    # if [ -d "$env_path" ]; then
    #     log_error "Environment $env_name already exists."
    #     return 1
    # fi
    #
    # mkdir -p "$env_path"
    # cd "$env_path" || return 1
    #
    # if [ "$type" = "python" ]; then
    #     uv venv .venv
    #     echo 'layout python' > .envrc
    # elif [ "$type" = "r" ]; then
    #     Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv')"
    #     Rscript -e "renv::init()"
    #     echo 'source renv/activate.R' > .envrc
    # else
    #     log_error "Invalid environment type: $type"
    #     return 1
    # fi
    #
    # direnv allow
    # log_info "Environment $env_name created in $env_path"
}

mkenv_py() {
    local env_name=$1
    local env_path="$PREM_DIR/env/venv/$env_name"
    uv venv $env_path/.venv
}

mkenv_r() {
    local env_name=$1
    local env_path="$PREM_DIR/env/renv/$env_name"
    mkdir -p $env_path
    cd $env_path
    Rscript -e 'library(renv)' -e 'renv::init()' -e 'q()' --no-save
    cd $PWD
}

# 環境削除
rmenv() {
    local env_name=$1
    local usage_msg="Usage: rmenv env-name -py/-r"
    
    if [ "$#" -gt 2 ]; then
        log_error "Too much arguments"
        echo $usage_msg
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
            Rscript -e 'renv::clean()' -e 'q()' --nosave
            rmdir_c $env_path
            cd $PWD
        else
            log_error "Invalid option type"
            echo $usage_msg
        fi
    fi
}

rmdir_c() {
    local dirpath=$1
    if [ -d "$dirpath" ]; then
        rm -rf "$dirpath"
        log_info "$env_name removed."
    else
        log_error "Environment $env_name does not exist."
    fi
}

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