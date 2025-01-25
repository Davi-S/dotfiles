diff --git a/files/etc/sddm.conf.d/10-wayland.conf b/files/etc/sddm.conf.d/10-wayland.conf
index b07ec65..583dfbc 100644
--- a/files/etc/sddm.conf.d/10-wayland.conf
+++ b/files/etc/sddm.conf.d/10-wayland.conf
@@ -2,3 +2,5 @@
 DisplayServer=wayland
 GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell
 
+[Wayland]
+CompositorCommand=kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1
