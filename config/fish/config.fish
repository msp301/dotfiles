function prompt_host
    set -l containerenv '/run/.containerenv'
    set -l host prompt_hostname
    if test -e $containerenv
        set host (cat $containerenv | grep 'name=' | cut -d\" -f2)
    end
    string collect $host
end

function prompt_is_toolbox
    if test -e '/run/.toolboxenv'
        string join '' -- (set_color magenta) ⬢ (set_color normal)
    end
end

function fish_prompt
    set -l last_status $status
    set -l stat
    if test $last_status -ne 0
        set stat (set_color red) "[$last_status]" (set_color normal)
    end

    string join '' -- (prompt_is_toolbox) ' ' (whoami)@(prompt_host) ' ' (set_color green) (prompt_pwd -D 2) (set_color normal) $stat '>'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
