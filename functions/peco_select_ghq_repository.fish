function peco_select_ghq_repository
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  ghq list | peco $peco_flags | read line

  if [ $line ]
    set full_path (ghq list --full-path --exact $line)
    cd $full_path
    if [ $TMUX ]
      tmux rename-window (basename $line)
    end
    commandline -f repaint
  end
end
