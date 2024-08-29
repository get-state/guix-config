function _tide_item_guix
   # print item       with this name   and this icon           with this text
   if test -n "$GUIX_ENVIRONMENT"
   _tide_print_item   guix          $tide_guix_icon''   "[GUIX ENV]"
end
end

