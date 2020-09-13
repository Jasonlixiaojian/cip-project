DISABLE_STATIC ?= " --disable-static"

# aide dependencies to build statically
DISABLE_STATIC_pn-aide = " " 
DISABLE_STATIC_pn-libgpg-error = " " 
DISABLE_STATIC_pn-libmhash = " " 
DISABLE_STATIC_pn-attr = " " 
DISABLE_STATIC_pn-acl = " " 
DISABLE_STATIC_pn-libpcre = " " 
EXTRA_OECONF_append_pn-aide = " --without-audit"
