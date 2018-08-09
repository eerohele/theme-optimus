function _current_dir
  string replace $HOME '~' $PWD
end

function _git_in_repo
  command git rev-parse --git-dir > /dev/null 2>&1
end

function _git_is_clean
  command git diff --no-ext-diff --quiet --exit-code
end

function _git_has_untracked_files
  count (command git ls-files --exclude-standard --others) > /dev/null
end

function _git_branch_name
  command git rev-parse --abbrev-ref HEAD 2> /dev/null
end

function _git_branch_indicator
  if _git_in_repo
    if not _git_is_clean
      set_color magenta
    else if _git_has_untracked_files
      set_color yellow
    else
      set_color cyan
    end
    _git_branch_name
  end
end

function _print_prompt_character
  if [ $argv = 0 ]
    set_color green
  else
    set_color red
  end

  echo -n " · "

  set_color normal
end

function fish_prompt
  set last_status $status
  echo -n (_current_dir)
  echo -n " "
  echo -n (_git_branch_indicator)
  _print_prompt_character $last_status
end
