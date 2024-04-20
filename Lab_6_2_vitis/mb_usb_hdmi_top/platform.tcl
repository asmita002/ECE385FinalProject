# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\dasan\OneDrive\Desktop\Lab_6_2_vitis\mb_usb_hdmi_top\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\dasan\OneDrive\Desktop\Lab_6_2_vitis\mb_usb_hdmi_top\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {mb_usb_hdmi_top}\
-hw {C:\Users\dasan\OneDrive\Documents\UIUC\2024 Spring\ECE 385\lab6\lab6_2_workspace\mb_usb_hdmi_top.xsa}\
-out {C:/Users/dasan/OneDrive/Desktop/Lab_6_2_vitis}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform generate -quick
platform clean
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {C:/Users/dasan/OneDrive/Documents/UIUC/2024 Spring/ECE 385/lab6/lab6_2_workspace/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform clean
platform config -updatehw {C:/Users/dasan/OneDrive/Documents/UIUC/2024 Spring/ECE 385/lab6/lab6_2_workspace/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform generate -domains 
platform clean
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/dasan/OneDrive/Documents/UIUC/2024 Spring/ECE 385/lab6/lab6_2_workspace/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform clean
platform config -updatehw {C:/Users/dasan/OneDrive/Documents/UIUC/2024 Spring/ECE 385/lab6/lab6_2_workspace/mb_usb_hdmi_top.xsa}
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/mb_usb_hdmi_top.xsa}
platform generate
