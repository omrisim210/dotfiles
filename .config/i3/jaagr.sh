#!/usr/bin/env bash

size_gap=5
size_border=1

lemonbuddy_config="${XDG_CONFIG_HOME}/lemonbuddy/testing/i3.conf"
lemonbuddy_bars=(top)

if x11::monitor_connected HDMI-1; then
  lemonbuddy_bars+=(external_top)
  lemonbuddy_bars+=(external_bottom)
fi

theme::pre_startup()
{
  if x11::monitor_connected HDMI-1; then
    b_wmname="$(lemonbuddy external_bottom -c "$lemonbuddy_config" --print-wmname)"
    b_height="$(lemonbuddy external_bottom -c "$lemonbuddy_config" --dump=height)"
    b_offset="$(lemonbuddy external_bottom -c "$lemonbuddy_config" --dump=offset_y)"
    b_border="$(lemonbuddy external_bottom -c "$lemonbuddy_config" --dump=border-top)"
    xdrawrect HDMI-1 bottom 100% 3 0 $((b_height+b_offset+b_border+3)) '#ff000000' effectline-bottom &
  fi
}

theme::post_startup()
{
  xdrawrect DVI-0 top 100% 3 0 27 \#ff000000 effectline-top "$(lemonbuddy i3_top -c "$lemonbuddy_config" --print-wmname)" &

  if x11::monitor_connected HDMI-1; then
    t_wmname="$(lemonbuddy external_top -c "$lemonbuddy_config" --print-wmname)"
    t_height="$(lemonbuddy external_top -c "$lemonbuddy_config" --dump=height)"
    t_offset="$(lemonbuddy external_top -c "$lemonbuddy_config" --dump=offset_y)"
    t_border="$(lemonbuddy external_top -c "$lemonbuddy_config" --dump=border-bottom)"
    xdrawrect HDMI-1 top 100% 3 0 $((t_height+t_offset+t_border)) \#ff000000 effectline-bottom &
  fi
}
