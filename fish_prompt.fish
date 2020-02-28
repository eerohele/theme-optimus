function _print_prompt_character
  if [ $argv = 0 ]
    set_color green
  else if [ $argv = 1 ]
    set_color red
  else
    set_color blue
  end

  printf "λ"
end

function fish_prompt
  set last_status $status
  string join ' ' (_print_prompt_character $last_status) '' | tr -d \n
end

