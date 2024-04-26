function fuzzy_select_ghq_repository
  set -l query (commandline)

  if test -n $query
    set query "$query"
  end

  ghq list | fzf --query $query | read line

  if [ $line ]
    set full_path (ghq list --full-path --exact $line)
    cd $full_path
    if [ $TMUX ]
      tmux rename-window (basename $line)
    end
    commandline -f repaint
  end
end
