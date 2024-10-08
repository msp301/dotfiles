function fish_prompt
    set -l last_status $status
    set -l stat
    if test $last_status -ne 0
        set stat (set_color red) "[$last_status]" (set_color normal)
    end

    set -l containerenv '/run/.containerenv'
    set -l host prompt_hostname
    if test -e $containerenv
        set host (cat $containerenv | grep 'name=' | cut -d\" -f2)
    end

    string join '' -- (whoami)@$host ' ' (set_color green) (prompt_pwd -D 2) (set_color normal) $stat '>'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
