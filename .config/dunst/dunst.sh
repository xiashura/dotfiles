dunst -config ~/.config/dunst/dunstrc \
  -cb "$(xgetres background)" \
  -lb "$(xgetres background)" \
  -nb "$(xgetres background)" \
  -cf "$(xgetres foreground)" \
  -lf "$(xgetres foreground)" \
  -nf "$(xgetres foreground)" \
  -bf "$(xgetres foreground)" \
  -frame_color "$(xgetres foreground)"
