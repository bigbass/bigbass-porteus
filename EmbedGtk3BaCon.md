#embed gtk3 in bacon


#summary Convert gtk3 official examples to BacCon .

The official site is http://www.basic-converter.org/
The official forum is http://basic-converter.proboards.com/



# BaCon with GTK3 and GTK2 Examples #

Getting started with sample widgets
Most of the examples have been converted from the gtk3 official examples
ported to BaCon code
as a reference only to make it easier to see
how to code it with BaCon

**TOP**    Sorry for the no color highlighting wiki doesn't have BaCon yet

| The widgets |
|:------------|
| [CHECK](#CHECK.md) | [SPINNER](#SPINNER.md) | [RADIO](#RADIO.md) |
| [TEXT](#TEXT.md) | [SWITCH2](#SWITCH2.md) | [SWITCH](#SWITCH.md) |
| [LABEL](#LABEL.md) | [HELLO2](#HELLO2.md) | [BUTTON](#BUTTON.md) |
| [DIALOG](#DIALOG.md) | [WINDOW](#WINDOW.md) | [TOGGLE-SPINNER](#TOGGLE-SPINNER.md) |
| [TABS3](#TABS3.md) | [NOTEBOOK](#NOTEBOOK.md) | [MENU](#MENU.md) |
| [MENU2](#MENU2.md) | [BUILDER](#BUILDER.md) | [GRID-PACKING](#GRID-PACKING.md)|
| [ENTRY](#ENTRY.md) | [PROGRESS](#PROGRESS.md) |[EXPANDER](#EXPANDER.md) |
| [SPINBUTTON](#SPINBUTTON.md) | [SPINBUTTON3](#SPINBUTTON3.md) |
| [FILESELECT](#FILESELECT.md) | [ASSISTANT](#ASSISTANT.md)|[GLADE1](#GLADE1.md)|
| [GOO-CANVAS](#GOO-CANVAS.md) | [FILECHOOSER](#FILECHOOSER.md) |
| [FSELECT](#FSELECT.md) | [HSCALE](#HSCALE.md) | [SCROLLED](#SCROLLED.md) |
| [KEYPRESSED](#KEYPRESSED.md) |[H&VSCALE](#H&VSCALE.md) |

---




**glade2bac**
a GUI tool to convert glade files automatically to
PROTO format with callbacks semi connected as simple print statements
| [GUI-GLADE2BAC  ](#GUI-GLADE2BAC.md) |
|:-------------------------------------|




---


## CHECK ##

how to convert official examples to Simplified embedded gtk ones in BaCon
using the new PROTO option

using this official example code as the reference
https://developer.gnome.org/gnome-devel-demos/3.5/checkbutton.c.html.en



|**Example code: check-gtk3-proto.bac**|
|:-------------------------------------|


```
PRAGMA LDFLAGS pkg-config --cflags --libs gtk+-3.0

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO gtk_window_set_title
PROTO gtk_container_add
PROTO gtk_toggle_button_set_active
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_title
PROTO gtk_application_new
PROTO gtk_application_window_new
PROTO gtk_check_button_new_with_label
PROTO g_signal_connect_data
PROTO gtk_toggle_button_get_active
PROTO gtk_main_quit

'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB





'====================
 SUB toggled_cb
'====================
       
	'--- signal handler for "toggled" signal of the CheckButton 
	TBUT = gtk_toggle_button_get_active (checkbutton)
	IF TBUT = 1 THEN
			gtk_window_set_title (window, "CheckButton Example")
	ELSE
			gtk_window_set_title (window, "Callback working")
	END IF
	PRINT TBUT       
END SUB
 

gtk_init(0, 0)  
window = gtk_window_new ()
gtk_window_set_title (window, "CheckButton Example")
gtk_window_set_default_size (window, 300, 100)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

checkbutton = gtk_check_button_new_with_label ("Show Title")
gtk_toggle_button_set_active (checkbutton, TRUE)

g_signal_connect_data(checkbutton, "notify::active",toggled_cb, 0, 0, 0)
gtk_container_add (window, checkbutton)
gtk_widget_show_all (window)    
gtk_main
 


```


[Back to top of document](#TOP.md)


---


## TEXT ##

another official example
https://developer.gnome.org/gnome-devel-demos/3.5/textview.c.html.en



|**Example code: text-gtk3-proto.bac**|
|:------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`



PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_container_add 
PROTO gtk_container_set_border_width 
PROTO gtk_scrolled_window_set_policy 
PROTO gtk_text_view_set_wrap_mode 
PROTO gtk_widget_show_all 
PROTO gtk_window_set_default_size 
PROTO gtk_window_set_title 
PROTO gtk_application_new 
PROTO gtk_application_window_new 
PROTO gtk_scrolled_window_new 
PROTO gtk_text_buffer_new 
PROTO gtk_text_view_new_with_buffer 

GTK_WRAP_WORD = 2
GTK_POLICY_AUTOMATIC = 1


'=====================
SUB exit_prog
'=====================
    gtk_main_quit
END SUB



 
	gtk_init(0, 0)
	
	'--- Create a window with a title, and a default size 
	window = gtk_window_new ()
	gtk_window_set_title (window, "TextView Example")
	gtk_window_set_default_size (window, 220, 200)
	g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
	
	'--- The text buffer represents the text being edited 
	buffer = gtk_text_buffer_new (NULL)
	
	
	'--- Text view is a widget in which can display the text buffer. 
	'--- The line wrapping is set to break lines in between words.
	
	text_view = gtk_text_view_new_with_buffer (buffer)
	gtk_text_view_set_wrap_mode (text_view, GTK_WRAP_WORD) 
	
	
	'--- Create the scrolled window. Usually NULL is passed for both parameters so 
	'--- that it creates the horizontal/vertical adjustments automatically. Setting 
	'--- the scrollbar policy to automatic allows the scrollbars to only show up 
	'--- when needed. 
	
	scrolled_window = gtk_scrolled_window_new (NULL, NULL)
	gtk_scrolled_window_set_policy (scrolled_window, GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC) 
	'--- The function directly below is used to add children to the scrolled window 
	'--- with scrolling capabilities (e.g text_view), otherwise, 
	'--- gtk_scrolled_window_add_with_viewport() would have been used
	
	gtk_container_add (scrolled_window, text_view)
	gtk_container_set_border_width (scrolled_window, 5)
	
	gtk_container_add (window, scrolled_window)	
	gtk_widget_show_all (window)	
	gtk_main	
	
	
	
	



```


[Back to top of document](#TOP.md)


---




## SPINNER ##

original code was not complete to show callbacks and a fully working example
https://developer.gnome.org/gnome-devel-demos/3.8/spinner.c.html.en

![http://bigbass-porteus.googlecode.com/files/spinner-gtk3-proto.png](http://bigbass-porteus.googlecode.com/files/spinner-gtk3-proto.png)




**had to add callbacks , buttons and signals**

|**Example code: spinner-gtk3-proto.bac**|
|:---------------------------------------|

```

PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`



PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO gtk_window_set_title
PROTO gtk_widget_show_all
PROTO g_signal_connect_data
PROTO gtk_spinner_new
PROTO gtk_spinner_start
PROTO gtk_spinner_stop
PROTO gtk_container_add
PROTO gtk_window_set_default_size
PROTO gtk_box_new
PROTO gtk_box_set_homogeneous
PROTO gtk_box_pack_start

PROTO gtk_radio_action_set_group(

GTK_ORIENTATION_VERTICAL = 1


'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB




'=====================
SUB radio_clicked()
'=====================
	
	CLEAR
	PRINT "button1"
	gtk_spinner_start (spinner)

END SUB




'=====================
SUB radio_clicked2()
'=====================
	CLEAR
	PRINT "button2"
	gtk_spinner_stop (spinner)

END SUB





gtk_init(0, 0)

window = gtk_window_new ()
gtk_window_set_default_size (window, 200, 200)
gtk_window_set_title (window, "Spinner test")
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

box = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
gtk_box_set_homogeneous (box, TRUE)

spinner = gtk_spinner_new ()


'---Create a radio button1 with a label
radio1 = gtk_radio_button_new_with_label_from_widget (radio1, "Start spinner.")
g_signal_connect_data(radio1, "clicked",radio_clicked, 0, 0, 0)



'---Create a radio button2 with a label
radio2 = gtk_radio_button_new_with_label_from_widget (radio2, "Stop spinner.")
g_signal_connect_data(radio2, "clicked",radio_clicked2, 0, 0, 0)
gtk_radio_action_set_group(radio1,2)

'---Pack them into a box, then show all the widgets
gtk_box_pack_start (box, radio1, TRUE, TRUE, 2
gtk_box_pack_start (box, radio2, TRUE, TRUE, 2)
gtk_box_pack_start (box, spinner, TRUE, TRUE, 2)
gtk_container_add (window, box)

gtk_widget_show_all (window)
gtk_main



```

[Back to top of document](#TOP.md)


---



## RADIO ##

https://developer.gnome.org/gnome-devel-demos/3.8/radiobutton.c.html.en



|**Example code: radio-gtk3-proto.bac**|
|:-------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`



PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_box_set_homogeneous
PROTO gtk_box_new
PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO gtk_widget_show_all

'--- set undeclared values
GTK_WINDOW_TOPLEVEL = 0
GTK_ORIENTATION_VERTICAL = 1

'=====================
SUB exit_prog
'=====================
    gtk_main_quit
END SUB



'=====================
SUB radio_clicked()
'=====================
    CLEAR
    PRINT "button1"
END SUB


'=====================
SUB radio_clicked2()
'=====================
    CLEAR
    PRINT "button2"
END SUB



'=====================
SUB radio_clicked3()
'=====================
    CLEAR
    PRINT "button3"
END SUB




gtk_init(0, 0)

window = gtk_window_new (GTK_WINDOW_TOPLEVEL)
box = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
gtk_box_set_homogeneous (box, TRUE)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

'---Create a radio button1 with a label
radio1 = gtk_radio_button_new_with_label_from_widget (radio1, "I'm the first radio button.")
g_signal_connect_data(radio1, "clicked",radio_clicked, 0, 0, 0)

'---Create a radio button2 with a label
radio2 = gtk_radio_button_new_with_label_from_widget (radio2, "I'm the second radio button.")
g_signal_connect_data(radio2, "clicked",radio_clicked2, 0, 0, 0)

'---Create a radio button3 with a label
radio3 = gtk_radio_button_new_with_label_from_widget (radio3, "I'm the third radio button.")
g_signal_connect_data(radio3, "clicked",radio_clicked3, 0, 0, 0)

'---Pack them into a box, then show all the widgets
gtk_box_pack_start (box, radio1, TRUE, TRUE, 2)
gtk_box_pack_start (box, radio2, TRUE, TRUE, 2)
gtk_box_pack_start (box, radio3, TRUE, TRUE, 2)
gtk_container_add (window, box)
gtk_widget_show_all (window)

gtk_main


```

[Back to top of document](#TOP.md)



---



## SWITCH2 ##

https://developer.gnome.org/gnome-devel-demos/3.5/switch.c.html.en

|**Example code: switch2-gtk3-proto.bac**|
|:---------------------------------------|

```

PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`



PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_container_add
PROTO gtk_widget_show_all
PROTO gtk_switch_new
PROTO gtk_window_set_title
PROTO gtk_window_set_default_size
PROTO gtk_container_set_border_width
PROTO gtk_switch_set_active
PROTO gtk_grid_set_column_spacing
PROTO gtk_grid_attach




'=====================
SUB exit_prog
'=====================
    gtk_main_quit
END SUB




'=====================
SUB switch_clicked()
'=====================
    CLEAR
    PRINT "switch button1"
    SW1 = gtk_switch_get_active (switch1)
    PRINT SW1
END SUB





gtk_init(0, 0)

'---Create a window with a set title and default size.
'---Also, set a border width for the amount of space
'---to leave inside the window

window = gtk_window_new ()
gtk_window_set_title (window, "Switch Example")
gtk_window_set_default_size (window, 300, 100)
gtk_container_set_border_width (window, 10)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)



'---Create a label---'
label = gtk_label_new ("Title")


'---Create a switch with a default active state
switch1 = gtk_switch_new ()
gtk_switch_set_active (switch1, TRUE)


'---Create a grid and set the column spacing,
'---attach the label
'---switch onto the grid
'---position them accordingly
grid = gtk_grid_new()
gtk_grid_set_column_spacing (grid, 10)
gtk_grid_attach (grid, label, 0, 0, 1, 1)
gtk_grid_attach (grid, switch1, 1, 0, 1, 1)

'---Connecting the clicked signal to the callback
g_signal_connect_data(switch1, "notify::active",switch_clicked, 0, 0, 0)


gtk_container_add (window, grid)
gtk_widget_show_all (window)
gtk_main

```

[Back to top of document](#TOP.md)





---




## SWITCH ##

![http://bigbass-porteus.googlecode.com/files/switch-gtk3-proto.png](http://bigbass-porteus.googlecode.com/files/switch-gtk3-proto.png)

|**Example code: switch-gtk3-proto.bac**|
|:--------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`



PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_box_set_homogeneous
PROTO gtk_box_new
PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO gtk_widget_show_all
PROTO gtk_switch_new 

'--- set undeclared values
GTK_WINDOW_TOPLEVEL = 0
GTK_ORIENTATION_VERTICAL = 1






'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB



'=====================
SUB switch_clicked()
'=====================
	CLEAR
	PRINT "switch button1"
	SW1 = gtk_switch_get_active (switch1)
	PRINT SW1
	END SUB


'=====================
SUB switch_clicked2()
'=====================
	CLEAR
	PRINT "switch button2"
	SW2 = gtk_switch_get_active (switch2)
	PRINT SW2
END SUB



'=====================
SUB switch_clicked3()
'=====================
	CLEAR
	PRINT "switch button3"
	SW3 = gtk_switch_get_active (switch3)
	PRINT SW3
END SUB




gtk_init(0, 0)

window = gtk_window_new (GTK_WINDOW_TOPLEVEL)

box = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
gtk_box_set_homogeneous (box, TRUE)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

label = gtk_label_new ("Switch Test ");


'---Create a switch button1
switch1 = gtk_switch_new ()
g_signal_connect_data(switch1, "notify::active",switch_clicked, 0, 0, 0)

'---Create a switch button2
switch2 = gtk_switch_new ()
g_signal_connect_data(switch2, "notify::active",switch_clicked2, 0, 0, 0)

'---Create a switch button3
switch3 = gtk_switch_new ()
g_signal_connect_data(switch3, "notify::active",switch_clicked3, 0, 0, 0)

'---Pack them into a box, then show all the widgets
gtk_box_pack_start (box, label, 0, 0, 1, 1)
gtk_box_pack_start (box, switch1, TRUE, TRUE, 2)
gtk_box_pack_start (box, switch2, TRUE, TRUE, 2)
gtk_box_pack_start (box, switch3, TRUE, TRUE, 2)
gtk_container_add (window, box)
gtk_widget_show_all (window)

gtk_main

```

[Back to top of document](#TOP.md)





---




## LABEL ##

ported from http://www.cs.dartmouth.edu/~xy/cs23/gtk.html
layout.c now call it label-gtk2-proto.bac by bigbass


![http://bigbass-porteus.googlecode.com/files/lable-gtk2-proto.png](http://bigbass-porteus.googlecode.com/files/lable-gtk2-proto.png)


|**Example code: label-gtk2-proto.bac**|
|:-------------------------------------|

```
'--- set up for compiling embedded library GTK
PRAGMA LDFLAGS pkg-config --cflags --libs gtk+-2.0 

'--- this replaces the need for IMPORT. the TYPE is not needed
'--- place all the functions that you will use here
 

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_window_set_title
PROTO gtk_window_set_position
PROTO gtk_window_set_default_size
PROTO gtk_label_new
PROTO gtk_hbox_new
PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO g_signal_connect_data,
PROTO g gtk_widget_show_all
PROTO gtk_main
PROTO gtk_main_quit
 

' get the needed missing values
GTK_WINDOW_TOPLEVEL = 0
GTK_WIN_POS_CENTER = 1
 

'===============
 SUB exit_prog
'===============
	gtk_main_quit
END SUB
 

gtk_init(0, 0)
window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_title(window, "Layout")
gtk_window_set_position(window, GTK_WIN_POS_CENTER)
gtk_window_set_default_size(window, 300, 200)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
 

label1 = gtk_label_new("Label 1")
label2 = gtk_label_new("Label 2")
label3 = gtk_label_new("Label 3")
 

hbox = gtk_hbox_new(TRUE, 5)
vbox = gtk_vbox_new(FALSE, 10)
 

gtk_box_pack_start(vbox, label1, TRUE, FALSE, 5)
gtk_box_pack_start(vbox, label2, TRUE, FALSE, 5)
gtk_box_pack_start(hbox, vbox, FALSE, FALSE, 5)
gtk_box_pack_start(hbox, label3, FALSE, FALSE, 5)
 

gtk_container_add(window, hbox)
gtk_widget_show_all(window)
gtk_main

```

[Back to top of document](#TOP.md)





---






## HELLO2 ##

ported from http://www.cs.dartmouth.edu/~xy/cs23/gtk.html

|**Example code: hello2-gtk2-proto.bac**|
|:--------------------------------------|

```
'--- set up for compiling embedded library GTK
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`



'--- this replaces the need for IMPORT. the TYPE is not needed
'--- place all the functions that you will use here

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_window_set_title
PROTO g_signal_connect_data,
PROTO g gtk_widget_show_all
PROTO gtk_main
PROTO gtk_main_quit


' get the needed missing values
GTK_WINDOW_TOPLEVEL = 0



'===============
SUB exit_prog
'===============
    gtk_main_quit
END SUB




gtk_init(0, 0)
window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_title(window, "Hello World!")

'--- Connect the main window to the destroy ---> replace with SUB exit_prog 
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
gtk_widget_show_all(window)        
gtk_main



```

[Back to top of document](#TOP.md)





---



## DIALOG ##

![http://bigbass-porteus.googlecode.com/files/dialog-gtk2-proto.png](http://bigbass-porteus.googlecode.com/files/dialog-gtk2-proto.png)


More help in simple terms

when the third arg is 0 the info icon is used

when the third arg is 1 the triangle warning icon is used

when the third arg is 2 the circle question mark icon is used

when the third arg is 3 the red circle with white line in the center icon is used

when the third arg is 4 no icon is used

using GTK terms the third arg some here not used but are offered as options you can use numbers or strings

CONST GTK\_MESSAGE\_INFO = 0

CONST GTK\_MESSAGE\_WARNING = 1

CONST GTK\_MESSAGE\_QUESTION = 2

CONST GTK\_MESSAGE\_ERROR = 3



the fourth arg 0 = no buttons displayed

the fourth arg 4 = yes and no buttons displayed

using GTK terms the fourth arg you can use numbers or strings

CONST GTK\_STOCK\_OK = 1

CONST GTK\_STOCK\_CLOSE = 2

CONST GTK\_STOCK\_CANCEL = 3

CONST GTK\_BUTTONS\_YES\_NO = 4

I used the string form to give an example of the fourth argument uses GTK\_STOCK\_OK

the fifth argument is the message you display between double quotes



|**Example code: dialog-gtk2-proto.bac**|
|:--------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`


PROTO gtk_init, gtk_message_dialog_new

CONST GTK_STOCK_OK = 1

gtk_init(0, 0)
x = gtk_dialog_run(gtk_message_dialog_new(0, 0, 0, GTK_STOCK_OK,"Greetings from BaCon!"))
```

[Back to top of document](#TOP.md)





---



## WINDOW ##

[http://]

|**Example code: window-gtk2-proto.bac**|
|:--------------------------------------|

```
'
'--- set up for compiling embedded library GTK
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`




'--- this replaces the need for IMPORT. the TYPE is not needed
'--- place all the functions that you will use here

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_window_set_title
PROTO gtk_window_set_position
PROTO gtk_window_set_default_size
PROTO gtk_label_new
PROTO gtk_hbox_new
PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO g_signal_connect_data,
PROTO g gtk_widget_show_all
PROTO gtk_main
PROTO gtk_main_quit


' get the needed missing values
GTK_WINDOW_TOPLEVEL = 0
GTK_WIN_POS_CENTER = 1




'===============
SUB exit_prog
'===============
gtk_main_quit
END SUB




gtk_init(0, 0)

window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_title(window, "Layout")
gtk_window_set_position(window, GTK_WIN_POS_CENTER)
gtk_window_set_default_size(window, 300, 200)

g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

label1 = gtk_label_new("Label 1")
label2 = gtk_label_new("Label 2")
label3 = gtk_label_new("Label 3")

hbox = gtk_hbox_new(TRUE, 5)
vbox = gtk_vbox_new(FALSE, 10)

gtk_box_pack_start(vbox, label1, TRUE, FALSE, 5)
gtk_box_pack_start(vbox, label2, TRUE, FALSE, 5)
gtk_box_pack_start(hbox, vbox, FALSE, FALSE, 5)
gtk_box_pack_start(hbox, label3, FALSE, FALSE, 5)

gtk_container_add(window, hbox)
gtk_widget_show_all(window)
gtk_main
```

[Back to top of document](#TOP.md)





---



## BUTTON ##

![http://bigbass-porteus.googlecode.com/files/button-gtk2-proto.png](http://bigbass-porteus.googlecode.com/files/button-gtk2-proto.png)

|**Example code: button-gtk2-proto.bac**|
|:--------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`


TRAP LOCAL


PROTO gtk_init,gtk_main_quit,gtk_window_new, gtk_window_set_default_size
PROTO gtk_window_set_title,gtk_table_new,gtk_container_add
PROTO gtk_table_attach_defaultsgtk_button_new_from_stock, gtk_table_attach_defaults
PROTO g_signal_connect_data, gtk_widget_show_all, gtk_main


SUB exit_prog
    gtk_main_quit
END SUB

gtk_init(0, 0)

window = gtk_window_new()
gtk_window_set_default_size(window, 200, 200)
gtk_window_set_title(window, "Hello world")

table = gtk_table_new(15, 15, 1)
gtk_container_add(window, table)
label = gtk_label_new("Bacon and GTK example!")
gtk_table_attach_defaults(table, label, 1, 8, 3, 7)

button = gtk_button_new_from_stock("gtk-quit")
gtk_table_attach_defaults(table, button, 10, 14, 12, 14)


g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
g_signal_connect_data(button, "clicked", exit_prog, 0, 0, 0)


gtk_widget_show_all(window)
gtk_main
```

[Back to top of document](#TOP.md)





---






## TOGGLE-SPINNER ##

![http://bigbass-porteus.googlecode.com/files/toggle-spinner-gtk3-proto.png](http://bigbass-porteus.googlecode.com/files/toggle-spinner-gtk3-proto.png)

|**Example code: toggle-spinner-gtk3-proto.bac**|
|:----------------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_container_add
PROTO gtk_widget_show_all
PROTO gtk_switch_new
PROTO gtk_window_set_title
PROTO gtk_window_set_default_size
PROTO gtk_container_set_border_width
PROTO gtk_switch_set_active
PROTO gtk_grid_set_column_spacing
PROTO gtk_grid_attach
PROTO gtk_spinner_new
PROTO gtk_spinner_start
PROTO gtk_spinner_stop

'=====================
SUB exit_prog
'=====================
    gtk_main_quit
END SUB



'=====================
SUB switch_clicked()
'=====================
CLEAR
PRINT "switch button1"
SW1 = gtk_switch_get_active (switch1)
IF SW1 = 1 THEN
        gtk_spinner_start (spinner)
ELSE
        gtk_spinner_stop (spinner)
END IF
PRINT SW1
END SUB






gtk_init(0, 0)

'---Create a window with a set title and default size.
'---Also, set a border width for the amount of space
'---to leave inside the window

window = gtk_window_new ()
gtk_window_set_title (window, "Switch Example")
gtk_window_set_default_size (window, 300, 100)
gtk_container_set_border_width (window, 10)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)



'---Create a label---'
label = gtk_label_new ("Spin")


'---Create a switch with a default active state
switch1 = gtk_switch_new ()
gtk_switch_set_active (switch1, FALSE)

spinner = gtk_spinner_new ()

'---Create a grid and set the column spacing,
'---attach the label
'---switch onto the grid
'---position them accordingly
grid = gtk_grid_new()
gtk_grid_set_column_spacing (grid, 10)
gtk_grid_attach (grid, label, 0, 0, 1, 1)
gtk_grid_attach (grid, switch1, 1, 0, 1, 1)

gtk_grid_attach (grid, spinner, 2, 0, 20, 20)

'---Connecting the clicked signal to the callback
g_signal_connect_data(switch1, "notify::active",switch_clicked, 0, 0, 0)


gtk_container_add (window, grid)
gtk_widget_show_all (window)
gtk_main

```

[Back to top of document](#TOP.md)



---



## TABS3 ##

![http://bigbass-porteus.googlecode.com/files/tabs3-gtk3-proto.png](http://bigbass-porteus.googlecode.com/files/tabs3-gtk3-proto.png)

|**Example code: tabs3-gtk3-proto.bac**|
|:-------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`


PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_button_new_with_label
PROTO gtk_label_new
PROTO gtk_notebook_new
PROTO gtk_window_new
PROTO gtk_container_add
PROTO gtk_init
PROTO gtk_main
PROTO gtk_notebook_append_page
PROTO gtk_widget_show
PROTO gtk_window_set_default_size
PROTO  gtk_widget_show_all

'--- set undeclared values
GTK_WINDOW_TOPLEVEL = 0


'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB



'=====================
SUB change_current_page_cb1()
'=====================
	'---  Example signal handler for page changes 
	PRINT "button 1 pressed"
END SUB





'=====================
SUB change_current_page_cb2()
'=====================
	'---  Example signal handler for page changes 
	PRINT "button 2 pressed"
END SUB


gtk_init(0, 0)

window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size(window, 200, 100)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

notebook = gtk_notebook_new()


'---  Append a test page to the notebook 
button1 = gtk_button_new_with_label ("button one")
gtk_widget_show(button1)
tab_label1 = gtk_label_new("tab 1")
gtk_notebook_append_page(notebook, button1,tab_label1)
g_signal_connect_data(button1, "clicked",change_current_page_cb1, 0, 0, 0)


'---  Append another test page to the notebook 
button2 = gtk_button_new_with_label("button two")
gtk_widget_show(button2)
tab_label2 = gtk_label_new("tab 2")
gtk_notebook_append_page(notebook, button2,tab_label2)
g_signal_connect_data(button2, "clicked",change_current_page_cb2, 0, 0, 0)



'---  Append another test page to the notebook 
button3 = gtk_button_new_with_label("button close")
gtk_widget_show(button3)
tab_label3 = gtk_label_new("close")
gtk_notebook_append_page(notebook, button3,tab_label3)
g_signal_connect_data(button3, "clicked",exit_prog, 0, 0, 0)


gtk_widget_show(notebook)
gtk_container_add(window, notebook)
gtk_widget_show(window)
gtk_main


```

[Back to top of document](#TOP.md)


---



## NOTEBOOK ##

![http://bigbass-porteus.googlecode.com/files/notebook3-gtk2-proto.png](http://bigbass-porteus.googlecode.com/files/notebook3-gtk2-proto.png)

source code was heavily modified during the conversion used only as a reference
http://www.dlhoffman.com/publiclibrary/software/gtk+-html-docs/gtk_tut-8.html


|**Example code: notebook3-gtk2-proto.bac**|
|:-----------------------------------------|

```

PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`



PROTO gtk_container_add
PROTO gtk_container_border_width
PROTO gtk_notebook_append_page
PROTO gtk_widget_set_usize
PROTO gtk_widget_show
PROTO gtk_container_add
PROTO gtk_init
PROTO gtk_main
PROTO gtk_main_quit
PROTO gtk_notebook_set_page
PROTO gtk_notebook_set_tab_pos
PROTO g_signal_connect_data
PROTO gtk_table_attach_defaults
PROTO gtk_widget_show
PROTO gtk_button_new_with_label
PROTO gtk_frame_new
PROTO gtk_label_new
PROTO gtk_notebook_new
PROTO gtk_table_new
PROTO gtk_window_new
PROTO gtk_notebook_set_current_page

GTK_POS_TOP = 2
tabnumber = 1


'=====================
SUB exit_prog
'=====================
gtk_main_quit
END SUB



'=====================
SUB gtk_notebook_next_page
'=====================
    
    CLEAR
    PRINT "next page" ,tabnumber
    
    '--- This function rotates the position of the tabs
    gtk_notebook_set_current_page(notebook, tabnumber)
    
    tabnumber = tabnumber +1
    IF tabnumber >= 3 THEN
        tabnumber = 3
    END IF     
END SUB


'=====================
SUB gtk_notebook_prev_page
'=====================

    CLEAR
    PRINT "prev page" ,    tabnumber    
    tabnumber = tabnumber -1
    
    '--- This function rotates the position of the tabs
    gtk_notebook_set_current_page(notebook, tabnumber)
    
    IF tabnumber < 1 THEN
        tabnumber = 1    
    END IF

END SUB




gtk_init(0, 0)
window = gtk_window_new ()
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)


table = gtk_table_new(2,6,TRUE)
gtk_container_add (window, table)

'--- Create a new notebook, place the position of the tabs
notebook = gtk_notebook_new ()
gtk_notebook_set_tab_pos (notebook, GTK_POS_TOP)
gtk_table_attach_defaults(table, notebook, 0,6,0,1)
gtk_widget_show(notebook)



frame = gtk_frame_new ()
gtk_widget_set_usize (frame, 100, 75)
gtk_widget_show (frame)

label = gtk_label_new ("Append Frame1",1)
gtk_container_add (frame, label)
gtk_widget_show (label)

label = gtk_label_new ("Page1",1)
gtk_notebook_append_page (notebook, frame, label)

'-------------------------------------------------

frame = gtk_frame_new ()
gtk_widget_set_usize (frame, 100, 75)
gtk_widget_show (frame)

label = gtk_label_new ("Append Frame2",2)
gtk_container_add (frame, label)
gtk_widget_show (label)

label = gtk_label_new ("Page2",2)
gtk_notebook_append_page (notebook, frame, label)

'-------------------------------------------------

frame = gtk_frame_new ()
gtk_widget_set_usize (frame, 100, 75)
gtk_widget_show (frame)

label = gtk_label_new ("Append Frame3",3)
gtk_container_add (frame, label)
gtk_widget_show (label)

label = gtk_label_new ("Page3",3)
gtk_notebook_append_page (notebook, frame, label)
'-------------------------------------------------



'--- Set what page to start at (page 1)
'gtk_notebook_set_page (notebook, 0)


'--- create a bunch of buttons
button = gtk_button_new_with_label ("close")
g_signal_connect_data(button, "clicked", exit_prog, 0, 0, 0)


gtk_table_attach_defaults(table, button, 0,1,1,2)
gtk_widget_show(button)

button = gtk_button_new_with_label ("next page")
g_signal_connect_data(button, "clicked",gtk_notebook_next_page, 0, 0, 0)

gtk_table_attach_defaults(table, button, 1,2,1,2)
gtk_widget_show(button)

button = gtk_button_new_with_label ("prev page")
g_signal_connect_data(button, "clicked",gtk_notebook_prev_page, 0, 0, 0)
gtk_table_attach_defaults(table, button, 2,3,1,2)
gtk_widget_show(button)

gtk_widget_show(table)
gtk_widget_show(window)
gtk_main


```

[Back to top of document](#TOP.md)


---




## MENU ##

http://zetcode.com/tutorials/gtktutorial/menusandtoolbars/

|**Example code: menu-gtk2-proto.bac**|
|:------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`

PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO gtk_init
PROTO gtk_main
PROTO gtk_menu_item_set_submenu
PROTO gtk_menu_shell_append
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_position
PROTO gtk_window_set_title
PROTO gtk_menu_bar_new
PROTO gtk_menu_item_new_with_label
PROTO gtk_menu_new
PROTO gtk_vbox_new
PROTO gtk_window_new
PROTO gtk_main_quit
PROTO g_signal_connect_data



' get the needed missing values
GTK_WINDOW_TOPLEVEL = 0
GTK_WIN_POS_CENTER = 1



'=====================
SUB exit_prog
'=====================
gtk_main_quit
END SUB



gtk_init(0,0)

window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_position(window, GTK_WIN_POS_CENTER)
gtk_window_set_default_size(window, 250, 200)
gtk_window_set_title(window, "menu")
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

vbox = gtk_vbox_new(FALSE, 0)
gtk_container_add(window, vbox)

menubar = gtk_menu_bar_new()
filemenu = gtk_menu_new()

file = gtk_menu_item_new_with_label("File")
quit = gtk_menu_item_new_with_label("Quit")

gtk_menu_item_set_submenu(file, filemenu)
gtk_menu_shell_append(filemenu, quit)
gtk_menu_shell_append(menubar, file)
gtk_box_pack_start(vbox, menubar, FALSE, FALSE, 3)

g_signal_connect_data(quit, "activate",exit_prog, 0, 0, 0)
gtk_widget_show_all(window)

gtk_main
```


[Back to top of document](#TOP.md)





## MENU2 ##

http://zetcode.com/tutorials/gtktutorial/menusandtoolbars/

Image menus,
**removed the  mnemonics & accelerators to make it easier to compile**


|**Example code: menu2-gtk3-proto.bac**|
|:-------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`


PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO gtk_init
PROTO gtk_main
PROTO gtk_menu_item_set_submenu
PROTO gtk_menu_shell_append
PROTO gtk_widget_add_accelerator
PROTO gtk_widget_show_all
PROTO gtk_window_add_accel_group
PROTO gtk_window_set_default_size
PROTO gtk_window_set_position
PROTO gtk_window_set_title
PROTO gtk_accel_group_new
PROTO gtk_image_menu_item_new_from_stock
PROTO gtk_menu_bar_new
PROTO gtk_menu_item_new_with_mnemonic
PROTO gtk_menu_new
PROTO gtk_separator_menu_item_new
PROTO gtk_vbox_new
PROTO gtk_window_new
PROTO gtk_main_quit
PROTO g_signal_connect_data



' get the needed missing values
GTK_WINDOW_TOPLEVEL = 0
GTK_WIN_POS_CENTER = 1

CONST GTK_STOCK_NEW = "gtk-new"
CONST GTK_STOCK_OPEN = "gtk-open"
CONST GTK_STOCK_QUIT = "gtk-quit"

GDK_CONTROL_MASK = 4
GTK_ACCEL_VISIBLE = 1



'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB



gtk_init(0,0)

window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_position(window, GTK_WIN_POS_CENTER)
gtk_window_set_default_size(window, 250, 200)
gtk_window_set_title(window, "menu")

vbox = gtk_vbox_new(FALSE, 0)
gtk_container_add(window, vbox)

menubar = gtk_menu_bar_new()
filemenu = gtk_menu_new()

accel_group = gtk_accel_group_new()
gtk_window_add_accel_group(window, accel_group)

file = gtk_menu_item_new_with_mnemonic("_File")
new = gtk_image_menu_item_new_from_stock(GTK_STOCK_NEW, NULL)
open = gtk_image_menu_item_new_from_stock(GTK_STOCK_OPEN, NULL)
sep = gtk_separator_menu_item_new()
quit = gtk_image_menu_item_new_from_stock(GTK_STOCK_QUIT) 


gtk_menu_item_set_submenu(file, filemenu)
gtk_menu_shell_append(filemenu, new)
gtk_menu_shell_append(filemenu, open)
gtk_menu_shell_append(filemenu, sep)
gtk_menu_shell_append(filemenu, quit)
gtk_menu_shell_append(menubar, file)
gtk_box_pack_start(vbox, menubar, FALSE, FALSE, 3)

g_signal_connect_data(quit, "activate",exit_prog, 0, 0, 0)
gtk_widget_show_all(window)
gtk_main

```


[Back to top of document](#TOP.md)

## BUILDER ##


This allows you to read in a builder.ui
place the builder.ui in the same place as builder-proto.bac

Thank you alexfish for this example

|**Example code: builder-proto.bac**|
|:----------------------------------|

```
'@ GTK BUILDER this is converted from Offical GTK-Demos , Should be able to install from repo's
'@ alexfish Bacon Converter Forums
'@ Should be able to read Glade Files , saved as Gtk-Builder Files

PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

PROTO gtk_init
PROTO gtk_builder_new
PROTO gtk_builder_add_from_file
PROTO gtk_builder_get_object
PROTO g_signal_connect_data
PROTO gtk_main_quit
PROTO gtk_main

gtk_init(0, 0)

'=====================
SUB exit_prog
'=====================
gtk_main_quit
END SUB

SUB button1_cb
    PRINT "button 1"
END SUB

SUB button2_cb
     PRINT "button 2"
END SUB


builder = gtk_builder_new ()
'@ change the path to the ui file
gtk_builder_add_from_file (builder, "builder.ui", NULL)

window = gtk_builder_get_object (builder, "window")
    g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)


button1 = gtk_builder_get_object (builder, "button1")
    g_signal_connect_data(button1, "clicked",button1_cb, 0, 0, 0)
    
button2 = gtk_builder_get_object (builder, "button2")
    g_signal_connect_data(button2, "clicked",button2_cb, 0, 0, 0)
    
quit = gtk_builder_get_object (builder, "quit")
    g_signal_connect_data(quit , "clicked",exit_prog, 0, 0, 0)
gtk_main

```




|**Example code: builder.ui**|
|:---------------------------|

this file gets read in on the fly  to modify the builder compiled app

```
<interface>
<object id="window" class="GtkWindow">
<property name="visible">True</property>
<property name="title">bacon Grid</property>
<property name="border-width">10</property>
<child>
<object id="grid" class="GtkGrid">
<property name="visible">True</property>
<child>
<object id="button1" class="GtkButton">
<property name="visible">True</property>
<property name="label">Button 1</property>
</object>
<packing>
<property name="left-attach">0</property>
<property name="top-attach">0</property>
</packing>
</child>
<child>
<object id="button2" class="GtkButton">
<property name="visible">True</property>
<property name="label">Button 2</property>
</object>
<packing>
<property name="left-attach">1</property>
<property name="top-attach">0</property>
</packing>
</child>
<child>
<object id="quit" class="GtkButton">
<property name="visible">True</property>
<property name="label">Quit</property>
</object>
<packing>
<property name="left-attach">0</property>
<property name="top-attach">1</property>
<property name="width">2</property>
</packing>
</child>
</object>
<packing>
</packing>
</child>
</object>
</interface>

```


[Back to top of document](#TOP.md)






## GRID-PACKING ##

![http://bigbass-porteus.googlecode.com/files/grid-packing.png](http://bigbass-porteus.googlecode.com/files/grid-packing.png)

ported from the grid-packing example in gtk sources
modified for BaCon use

|**Example code: grid-packing-proto.bac**|
|:---------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

PROTO gtk_container_add 
PROTO gtk_container_set_border_width 
PROTO gtk_grid_attach 
PROTO gtk_init 
PROTO gtk_main 
PROTO gtk_widget_show_all 
PROTO gtk_window_set_title 
PROTO gtk_button_new_with_label 
PROTO gtk_grid_new 
PROTO gtk_window_new 
PROTO g_signal_connect_data
PROTO gtk_main_quit

GTK_WINDOW_TOPLEVEL = 0

'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB


'=====================
SUB button1_cb
'=====================
	PRINT "button 1"
END SUB


'=====================
SUB button2_cb
'=====================
	PRINT "button 2"
END SUB




'---  This is called in all GTK applications. Arguments are parsed
'---  from the command line and are returned to the application.

gtk_init (0,0)

'---  create a new window, and set its title
window = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_title (window, "Grid")
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
gtk_container_set_border_width (window, 10)

'---  Here we construct the container that is going pack our buttons
grid = gtk_grid_new ()

'---  Pack the container in the window
gtk_container_add (window, grid)

button1 = gtk_button_new_with_label ("Button 1")
g_signal_connect_data(button1, "clicked",button1_cb, 0, 0, 0)

'---  Place the first button in the grid cell (0, 0), and make it fill
'---  just 1 cell horizontally and vertically (ie no spanning)

gtk_grid_attach (grid, button1, 0, 0, 1, 1)

button2 = gtk_button_new_with_label ("Button 2")
g_signal_connect_data(button2, "clicked",button2_cb, 0, 0, 0)

'---  Place the second button in the grid cell (1, 0), and make it fill
'---  just 1 cell horizontally and vertically (ie no spanning)

gtk_grid_attach (grid, button2, 1, 0, 1, 1)

button3 = gtk_button_new_with_label ("Quit")
g_signal_connect_data(button3  , "clicked",exit_prog, 0, 0, 0)

'---  Place the Quit button in the grid cell (0, 1), and make it
'---  span 2 columns.

gtk_grid_attach (grid, button3, 0, 1, 2, 1)

'---  Now that we are done packing our widgets, we show them all
'---  in one go, by calling gtk_widget_show_all() on the window.
'---  This call recursively calls gtk_widget_show() on all widgets
'---  that are contained in the window, directly or indirectly.

gtk_widget_show_all (window)

'---  All GTK applications must have a gtk_main(). Control ends here
'---  and waits for an event to occur (like a key press or a mouse event),
'---  until gtk_main_quit() is called.

gtk_main 

```


[Back to top of document](#TOP.md)



## ENTRY ##

source code converted to PROTO
https://developer.gnome.org/gnome-devel-demos/3.5/entry.c.html.en

|**Example code: entry-gtk3-proto.bac**|
|:-------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_main
PROTO gtk_container_add
PROTO gtk_container_set_border_width
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_title
PROTO gtk_entry_get_text
PROTO gtk_entry_new



'=======================
SUB EXIT_PROG()
'=======================
    gtk_main_quit
END SUB



'---This is the callback function. It is a handler function
'---which reacts to the signal. In this case, it will grab the
'---text input from the entry box and print out a line to the user.
'---when you press enter

'=======================
SUB on_activate
'=======================
    name$ = (char *)gtk_entry_get_text (entry_box)
    PRINT name$
END SUB



gtk_init(0, 0)

'---Create a window with a title, a default size,
'---and a set border width
window = gtk_window_new ()
gtk_window_set_title (window, "To get the entry press enter")
gtk_window_set_default_size (window, 350, 100)
gtk_container_set_border_width (window, 10)
g_signal_connect_data(window, "destroy", EXIT_PROG, 0, 0, 0)

'---Create a new entry box, and add it to the window
entry_box = gtk_entry_new ()
gtk_container_add (window, entry_box)

'---Connecting the activate signal to the callback
g_signal_connect_data (entry_box, "activate", on_activate,0,0,0)

gtk_widget_show_all (window)
gtk_main

```


[Back to top of document](#TOP.md)


## PROGRESS ##

![http://bigbass-porteus.googlecode.com/files/timeout.png](http://bigbass-porteus.googlecode.com/files/timeout.png)


This is how to add a timeout to GTK3
and use it with PROTO

now the progressbar auto updates automatically
there wasn't a complete simple example so I had to make one

and notice pointer free code


|**Example code: progress-gtk3-proto.bac**|
|:----------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main_quit
PROTO gtk_main
PROTO gtk_container_add
PROTO gtk_grid_attach
PROTO gtk_grid_attach_next_to
PROTO gtk_progress_bar_pulse
PROTO gtk_widget_show_all
PROTO gtk_window_set_title
PROTO gtk_application_new
PROTO gtk_button_new_with_label
PROTO gtk_grid_new
PROTO gtk_progress_bar_new
PROTO gtk_window_new
PROTO g_signal_connect_data
PROTO gtk_progress_bar_set_fraction
PROTO gtk_progress_bar_get_fraction
PROTO gtk_window_set_default_size
PROTO  g_timeout_add

GTK_POS_BOTTOM = 3

fraction = 0.1

'---How to use a time out to update a progress bar

'=============================
FUNCTION timeout_callback
'=============================

    gtk_progress_bar_pulse (progress_bar)   

    '---Increase the bar by 10% each time this function is called

    '---Fill in the bar with the new fraction
    gtk_progress_bar_set_fraction (progress_bar, fraction)

    fraction = fraction + 0.1
    IF fraction >= 1 THEN
        fraction = 0
    END IF
 
    RETURN TRUE

END FUNCTION



'==============
SUB EXIT_PROG
'==============
    gtk_main_quit
END SUB




gtk_init(0, 0)

'---Create the window and set a title
window = gtk_window_new ()
gtk_window_set_title (window, "Progress Example")
gtk_window_set_default_size (window, 270, 70)
g_signal_connect_data(window, "destroy", EXIT_PROG, 0, 0, 0)


'---Create a button with a label
button = gtk_button_new_with_label ("QUIT")

'---Create the progress bar
progress_bar = gtk_progress_bar_new ()

'---Create a grid and attach the button and progress bar accordingly
grid = gtk_grid_new ()
gtk_grid_attach (grid, button, 1, 1, 1, 1)
gtk_grid_attach_next_to (grid, \
                     progress_bar, \
                     button, \
                     GTK_POS_BOTTOM, 1, 1)

'---Connecting the clicked signal to the callback function
g_signal_connect_data (button, "clicked", EXIT_PROG)


g_timeout_add(500, timeout_callback, NULL)
gtk_container_add (window, grid)
gtk_widget_show_all (window)
gtk_main


```


[Back to top of document](#TOP.md)




## EXPANDER ##

![http://bigbass-porteus.googlecode.com/files/exapander.png](http://bigbass-porteus.googlecode.com/files/exapander.png)

thanks alexfish for this example

|**Example code: expander-gtk3-proto.bac**|
|:----------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

'@ Expander demo by alexfish `bacon converter forum`


PROTO gtk_init
PROTO gtk_window_new
PROTO gtk_main
PROTO gtk_main_quit
PROTO gtk_window_set_title
PROTO gtk_container_add
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_title
PROTO gtk_label_new
PROTO gtk_expander_new_with_mnemonic
PROTO gtk_expander_set_expanded
PROTO gtk_box_new
PROTO gtk_box_set_homogeneous
PROTO gtk_box_pack_start
PROTO g_signal_connect_data

'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB
'====================
    GTK_WINDOW_TOPLEVEL = 0
    GTK_ORIENTATION_VERTICAL = 1



gtk_init(0, 0)

window = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_title (window, "Expander Example")
gtk_window_set_default_size (window, 300, 200)
    g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
    
box1 = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
    gtk_box_set_homogeneous (box1, TRUE)

lab1 = gtk_label_new_with_mnemonic ("BaCon ConVerter")
    gtk_box_pack_start (box1, lab1, TRUE, TRUE, 2)    

exp_1=gtk_expander_new_with_mnemonic("click me")
    gtk_box_pack_start (box1, exp_1, TRUE, TRUE, 2)
    lab2 = gtk_label_new_with_mnemonic ("BaCon is Brill")
    gtk_container_add(exp_1,lab2)

    gtk_container_add(window,box1)
    
gtk_widget_show_all (window)
gtk_main

```


[Back to top of document](#TOP.md)


## SPINBUTTON ##

source that was ported to PROTO
http://read.pudn.com/downloads154/sourcecode/unix_linux/679094/rule/spinButton.c__.htm


This is the first example I used pointers and included the gtk.h
the first time in about 20 examples

(I hope to later convert it to pointer free code )

|**Example code: spinbutton-gtk2-proto.bac**|
|:------------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`
PRAGMA INCLUDE gtk-2.0/gtk/gtk.h


PROTO gtk_window_set_title
PROTO gtk_box_pack_start
PROTO gtk_container_add
PROTO gtk_init
PROTO gtk_main
PROTO gtk_widget_show
PROTO gtk_widget_show_all
PROTO gtk_adjustment_new
PROTO gtk_button_new_with_label
PROTO gtk_hbox_new
PROTO gtk_label_new
PROTO gtk_spin_button_get_value_as_int
PROTO gtk_spin_button_new
PROTO gtk_window_new
PROTO gtk_main_quit
PROTO g_signal_connect_data
PROTO gtk_window_set_default_size

GLOBAL *window TYPE GtkWidget
GLOBAL *button TYPE GtkWidget
GLOBAL *label TYPE GtkWidget
GLOBAL *box TYPE GtkWidget
GLOBAL *spin TYPE GtkWidget


GLOBAL *adjustment TYPE GtkObject


'==============
SUB EXIT_PROG
'==============
    gtk_main_quit
END SUB


'==============
SUB button_event
'==============

    value = gtk_spin_button_get_value_as_int(GTK_SPIN_BUTTON(spin))
    PRINT value
END SUB




gtk_init(0, 0)

window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW(window), 270, 50)


'---Connecting the clicked signal to the callback function
g_signal_connect_data(window, "destroy", EXIT_PROG, 0, 0, 0)


box = gtk_hbox_new(FALSE, 0)
gtk_container_add(GTK_CONTAINER(window), box)

adjustment = gtk_adjustment_new(2013, 1900, 2100, 1, 1, 0)
spin = gtk_spin_button_new(GTK_ADJUSTMENT(adjustment), 0.5, 0)
gtk_box_pack_start(GTK_BOX(box), spin, TRUE, TRUE, 5)
gtk_widget_show(spin)

label = gtk_label_new("year")
gtk_box_pack_start(GTK_BOX(box), label, TRUE, TRUE, 0)
gtk_widget_show(label)

button = gtk_button_new_with_label("button")
gtk_box_pack_start(GTK_BOX(box), button, TRUE, TRUE, 0)

g_signal_connect_data(button, "clicked", button_event, 0, 0, 0)
gtk_widget_show(button)

gtk_widget_show(box)
gtk_widget_show(window)


gtk_main 
```


[Back to top of document](#TOP.md)

## NOTYET ##

[http://]

|**Example code: notyet.bac**|
|:---------------------------|

```

```


[Back to top of document](#TOP.md)

## NOTYET ##

[http://]

|**Example code: notyet.bac**|
|:---------------------------|

```

```


[Back to top of document](#TOP.md)

## SPINBUTTON3 ##


original code ported and modified
https://developer.gnome.org/gnome-devel-demos/stable/spinbutton.c.html.en


|**Example code: spinbutton-gtk3-proto.bac**|
|:------------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`
PRAGMA INCLUDE gtk-3.0/gtk/gtk.h



PROTO gtk_label_set_text
PROTO gtk_container_add
PROTO gtk_container_set_border_width
PROTO gtk_grid_attach
PROTO gtk_grid_set_column_homogeneous
PROTO gtk_grid_set_column_spacing
PROTO gtk_widget_set_hexpand
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_title
PROTO gtk_adjustment_new
PROTO gtk_application_new
PROTO gtk_window_new
PROTO gtk_grid_new
PROTO gtk_label_new
PROTO gtk_spin_button_get_value_as_int
PROTO gtk_spin_button_new
PROTO gtk_init
PROTO gtk_main
PROTO g_signal_connect_data
PROTO gtk_main_quit



'--- Declare variables
GLOBAL *window TYPE GtkWidget
GLOBAL *label TYPE GtkWidget
GLOBAL *grid TYPE GtkWidget
GLOBAL *spin_button TYPE GtkWidget

GLOBAL *adjustment TYPE GtkAdjustment




'==============
SUB EXIT_PROG
'==============
    gtk_main_quit
END SUB




'--- This is the callback function.
'--- It is a handler function which reacts to the signal.
'--- In this case, it will notify the user the value of their spinbutton

'==============
SUB spin_clicked
'==============
    value = gtk_spin_button_get_value_as_int (GTK_SPIN_BUTTON(spin_button))
    PRINT value     
END SUB





gtk_init(0, 0)

'--- Create a window with a title, a border width, and a default size
window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_title (GTK_WINDOW (window), "SpinButton Example")
gtk_window_set_default_size (GTK_WINDOW (window), 270, 70)
gtk_container_set_border_width (GTK_CONTAINER (window), 5)

'---Connecting the clicked signal to the callback function
g_signal_connect_data(window, "destroy", EXIT_PROG, 0, 0, 0)

'--- Create a label to be shown in the window
label = gtk_label_new ("Press enter to get the value")

'--- Create an adjustment representing an adjustable bounded value
adjustment = gtk_adjustment_new (0, 0, 100, 1, 0, 0)


'--- Create a spin button that is to be as wide as possible
spin_button = gtk_spin_button_new (adjustment, 1, 0)
gtk_widget_set_hexpand (spin_button, TRUE)

'--- Connecting the "value-changed" signal for the spinbutton
'--- to the appropriate callback function.
g_signal_connect_data(spin_button, "activate", spin_clicked, 0, 0, 0)

'--- Create a grid and arrange everything accordingly
grid = gtk_grid_new ()
gtk_grid_set_column_spacing (GTK_GRID (grid), 10)
gtk_grid_set_column_homogeneous (GTK_GRID (grid), TRUE)
gtk_grid_attach (GTK_GRID (grid), spin_button, 0, 0, 1, 1)
gtk_grid_attach (GTK_GRID (grid), label, 0, 1, 1, 1)

gtk_container_add (GTK_CONTAINER (window), grid)
gtk_widget_show_all (window)
gtk_main 
```


[Back to top of document](#TOP.md)

## FILESELECT ##

![http://bigbass-porteus.googlecode.com/files/fileselect-fixed.png](http://bigbass-porteus.googlecode.com/files/fileselect-fixed.png)

No pointers and built in buttons get connected to to the low level signals

|**Example code: fileselect-gtk2-proto.bac**|
|:------------------------------------------|

```

PRAGMA LDFLAGS pkg-config --cflags --libs gtk+-2.0

PROTO gtk_file_selection_set_filename
PROTO gtk_init
PROTO gtk_main
PROTO gtk_widget_show
PROTO gtk_file_selection_new
PROTO g_signal_connect_data
PROTO gtk_main_quit
PROTO gtk_dialog_run
PROTO gtk_widget_destroy
PROTO g_timeout_add
PROTO gtk_exit

'--- low level button signals 
CONST GTK_RESPONSE_OK = -5
CONST GTK_RESPONSE_CANCEL = -6
CONST GTK_RESPONSE_CLOSE = -7
CONST GTK_RESPONSE_DELETE_EVENT = -4


'=====================
SUB exit_prog()
'=====================

    PRINT "HERE"
    gtk_exit(0)
END SUB




'=====================
SUB file_ok_sel()
'=====================
'--- Get the selected filename and print it to the console

	PRINT "you got to the call back file_ok_sel"
    selected$ = (char *)gtk_file_selection_get_filename (filew)
    PRINT selected$
END SUB



gtk_init (0, 0)

'--- Create a new file selection widget
filew = gtk_file_selection_new ("File selection")




'--- Lets set the filename, as if this were a save dialog, and we are giving a default filename
gtk_file_selection_set_filename (filew, "penguin.png")

'--- GTK_RESPONSE_OK
'--- major work around to connect buttons using the reponses 
'--- after a modified callback using just the callback name 
IF gtk_dialog_run(filew ) = GTK_RESPONSE_OK  THEN
	PRINT "The low level OK button was pressed "
	file_ok_sel
END IF



'--- GTK_RESPONSE_CANCEL
'--- major work around to connect buttons using the reponses 
'--- after a modified callback using just the callback name 
IF gtk_dialog_run(filew ) = GTK_RESPONSE_CANCEL  THEN
	PRINT "The low level CANCEL button was pressed "
	PRINT "close main window"	
	exit_prog
	
	

END IF

g_signal_connect_data(filew, "destroy", exit_prog, 0, 0, 0)


gtk_widget_show (filew)
gtk_main 

PRINT "The top level window of the application was closed...Exiting the program"


```




[Back to top of document](#TOP.md)

## ASSISTANT ##

![http://bigbass-porteus.googlecode.com/files/assistant.png](http://bigbass-porteus.googlecode.com/files/assistant.png)

Thanks alexfish for this example
|**Example code: assistant-gtk3-proto.bac**|
|:-----------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`

'@ ASSISTANT DEMO

PROTO gtk_init
PROTO gtk_main
PROTO gtk_main_quit
PROTO gtk_box_new
PROTO gtk_box_set_homogeneous
PROTO gtk_box_pack_start

PROTO gtk_assistant_new
PROTO gtk_assistant_append_page
PROTO gtk_assistant_set_page_type
PROTO gtk_assistant_commit
PROTO gtk_assistant_set_page_complete
PROTO gtk_assistant_set_page_type
PROTO gtk_assistant_set_page_title

PROTO gtk_window_set_title
PROTO gtk_widget_set_size_request

PROTO gtk_button_new_with_label
PROTO gtk_label_new_with_mnemonic

PROTO gtk_entry_new
PROTO gtk_entry_set_text

'@ Note this line may produce err in bacon2 + bacon2.bash
PROTO gtk_entry_get_text

PROTO gtk_widget_show_all

PROTO g_signal_connect_data

    GTK_WINDOW_TOPLEVEL = 0
    GTK_ORIENTATION_VERTICAL = 1

    GTK_ASSISTANT_PAGE_CONTENT = 0
    GTK_ASSISTANT_PAGE_INTRO = 1
    GTK_ASSISTANT_PAGE_CONFIRM = 2
    GTK_ASSISTANT_PAGE_SUMMARY = 3
    GTK_ASSISTANT_PAGE_PROGRESS = 4
    GTK_ASSISTANT_PAGE_CUSTOM = 5


gtk_init(0, 0)
'=====================
SUB exit_prog
'=====================
	gtk_main_quit
END SUB

SUB get_name
    name$ = (char *)gtk_entry_get_text(ent1)
    name$ = CONCAT$("submit / " ,name$)
    gtk_entry_set_text(ent2,name$)
END SUB

SUB submit
    name$ = (char *)gtk_entry_get_text(ent2)
    PRINT "Membership Application Approved",NL$,"Latest Member, ",name$
    '@ quit
    gtk_main_quit
END SUB

assist_1 = gtk_assistant_new ()
    gtk_widget_set_size_request(assist_1,400,300)
    gtk_window_set_title (assist_1, "GtkAssistant Example")
    g_signal_connect_data(assist_1, "delete-event", exit_prog, 0, 0, 0)
    g_signal_connect_data(assist_1, "apply", submit, 0, 0, 0)
    
box1 = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
    gtk_box_set_homogeneous (box1, TRUE)

box2 = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
    gtk_box_set_homogeneous (box2, TRUE)

box3 = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
    gtk_box_set_homogeneous (box3, TRUE)


box4 = gtk_box_new (GTK_ORIENTATION_VERTICAL, 2)
    gtk_box_set_homogeneous (box4, TRUE)


lab1 = gtk_label_new_with_mnemonic ("BaCon ConVerter")

lab2 = gtk_label_new_with_mnemonic ("Bacon is Brill")

lab3 = gtk_label_new_with_mnemonic ("Forum Membership")

ent1=gtk_entry_new()
gtk_entry_set_text(ent1,"enter name here")

but4 = gtk_button_new_with_label ("OK")
g_signal_connect_data(but4, "clicked", get_name, 0, 0, 0)

lab5 = gtk_label_new_with_mnemonic ("Submit Aplication")
ent2 = gtk_entry_new()

    gtk_box_pack_start (box1, lab1, TRUE, TRUE, 2)
    gtk_box_pack_start (box2, lab2, TRUE, TRUE, 2)
    gtk_box_pack_start (box3, lab3, TRUE, TRUE, 2)
    gtk_box_pack_start (box3, ent1, TRUE, TRUE, 2)
    gtk_box_pack_start (box3, but4, TRUE, TRUE, 2)
    gtk_box_pack_start (box4, lab5, TRUE, TRUE, 2)
    gtk_box_pack_start (box4, ent2, TRUE, TRUE, 2)
        
page_1 = gtk_assistant_append_page(assist_1,box1)
gtk_assistant_set_page_title(assist_1,box1,"About")
gtk_assistant_set_page_type(assist_1, box1 , GTK_ASSISTANT_PAGE_CONTENT)
gtk_assistant_set_page_complete(assist_1,box1,TRUE)

page_2 = gtk_assistant_append_page(assist_1,box2)
gtk_assistant_set_page_title(assist_1,box2,"Introduction")
gtk_assistant_set_page_type(assist_1, box2 , GTK_ASSISTANT_PAGE_INTRO)
gtk_assistant_set_page_complete(assist_1, box2 ,TRUE)

page_3 = gtk_assistant_append_page(assist_1,box3)
gtk_assistant_set_page_title(assist_1,box3,"Details")
gtk_assistant_set_page_type(assist_1, box3 , GTK_ASSISTANT_PAGE_PROGRESS)
gtk_assistant_set_page_complete(assist_1, box3 ,TRUE)

page_4 = gtk_assistant_append_page(assist_1,box4)
gtk_assistant_set_page_title(assist_1,box4,"Register")
gtk_assistant_set_page_type(assist_1, box4 , GTK_ASSISTANT_PAGE_CONFIRM)
gtk_assistant_set_page_complete(assist_1, box4 ,TRUE)

gtk_widget_show_all (assist_1)

gtk_main

```




[Back to top of document](#TOP.md)

## GLADE1 ##

![http://bigbass-porteus.googlecode.com/files/glade-demo2.png](http://bigbass-porteus.googlecode.com/files/glade-demo2.png)



I converted Peter's wonderful demo
http://www.basic-converter.org/glade-demo.bac.html


and glade.bac to embedded PROTO with PRAGMA  this is built in
glade.bac isnt a dependency now
http://www.basic-converter.org/glade.bac.html


notice that we use **libglade-2.0** at compile time
PRAGMA LDFLAGS `pkg-config --cflags --libs libglade-2.0`




|**Example code: glade-demo2-proto.bac**|
|:--------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs libglade-2.0`

'---
'--- Bacon and Glade and GTK.
'--- PvE - April 2009.
'---
'--- Improved August 18, 2009 - PvE.
'--- Improved February 20, 2010 - PvE.
'---

'--- Get functions from GLADE

'==========================================
'--- ported to PROTO and PRAGMA by bigbass
'--- April 19 2013 notice --libs libglade-2.0
'==========================================

'--- (char *) fix by vovchik April 19 2013



'--- Get needed functions from glade using PROTO

PROTO glade_require
PROTO glade_provide
PROTO glade_xml_new
PROTO glade_xml_new_from_buffer
PROTO glade_xml_construct
PROTO glade_xml_construct_from_buffer
PROTO glade_xml_signal_connect
PROTO glade_xml_signal_connect_data
PROTO glade_xml_signal_autoconnect
PROTO glade_xml_get_widget
PROTO glade_xml_get_widget_prefix
PROTO glade_get_widget_name
PROTO glade_get_widget_tree
PROTO glade_xml_signal_connect_full
PROTO glade_xml_signal_autoconnect_full
PROTO glade_set_custom_handler
PROTO glade_parser_parse_file
PROTO glade_parser_parse_buffer
PROTO glade_interface_destroy
PROTO glade_interface_dump
PROTO glade_xml_build_widget
PROTO glade_xml_handle_internal_child
PROTO glade_xml_set_common_params
PROTO glade_register_widget
PROTO glade_standard_build_widget
PROTO glade_xml_handle_widget_prop
PROTO glade_standard_build_children
PROTO glade_xml_set_packing_property
PROTO glade_register_custom_prop
PROTO glade_xml_relative_file
PROTO glade_enum_from_string
PROTO glade_flags_from_string
PROTO glade_xml_set_value_from_string
PROTO glade_xml_set_toplevel
PROTO glade_xml_ensure_accel



'--- Get needed functions from GTK using PROTO
PROTO gtk_main
PROTO gtk_exit
PROTO gtk_entry_get_text
PROTO gtk_init
PROTO g_signal_connect_data
PROTO gtk_main_quit

'--- Callback for closing window
SUB exit_prog
gtk_main_quit
END SUB

'--- Callback to get entry contents
SUB get_entry()
    result$ = (char *)gtk_entry_get_text(entry)
    PRINT result$
END SUB

'--- Setup GUI
gtk_init(0, 0)


'--- Get Glade file
xml = glade_xml_new("./demo.glade", 0, 0)
glade_xml_signal_autoconnect(xml)

'--- Get main window ID and connect signal
window = glade_xml_get_widget(xml, "window")
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

'--- Get exit button ID and connect signal
quit = glade_xml_get_widget(xml, "exit_button")
g_signal_connect_data(quit, "clicked", exit_prog, 0, 0, 0)

'--- Get entry
entry = glade_xml_get_widget(xml, "entry")

'--- Get print button ID and connect signal and pass entry as data to callback function
button = glade_xml_get_widget(xml, "print_button")
g_signal_connect_data(button, "clicked", get_entry, entry, 0, 0)

'--- Endless event handling by GTK
gtk_main


```






**The glade file**


|**Example code: demo.glade**|
|:---------------------------|

```
<?xml version="1.0" encoding="UTF-8"?>
<glade-interface>
<widget class="GtkWindow" id="window">
<property name="height_request">300</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="title" translatable="yes">Designed with Glade</property>
<property name="default_width">400</property>
<property name="default_height">400</property>
<child>
<widget class="GtkTable" id="table1">
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="n_rows">12</property>
<property name="n_columns">11</property>
<child>
<widget class="GtkEntry" id="entry">
<property name="visible">True</property>
<property name="can_focus">True</property>
<property name="text" translatable="yes">Enter some text here</property>
<property name="primary_icon_activatable">False</property>
<property name="secondary_icon_activatable">False</property>
<property name="primary_icon_sensitive">True</property>
<property name="secondary_icon_sensitive">True</property>
</widget>
<packing>
<property name="left_attach">1</property>
<property name="right_attach">8</property>
<property name="top_attach">4</property>
<property name="bottom_attach">6</property>
<property name="x_options">GTK_FILL</property>
<property name="y_options"/>
</packing>
</child>
<child>
<widget class="GtkStatusbar" id="statusbar1">
<property name="visible">True</property>
<property name="can_focus">False</property>
</widget>
<packing>
<property name="right_attach">11</property>
<property name="top_attach">11</property>
<property name="bottom_attach">12</property>
<property name="x_options">GTK_FILL</property>
<property name="y_options"/>
</packing>
</child>
<child>
<widget class="GtkButton" id="exit_button">
<property name="label" translatable="yes">Exit</property>
<property name="width_request">35</property>
<property name="height_request">45</property>
<property name="visible">True</property>
<property name="can_focus">True</property>
<property name="receives_default">False</property>
<property name="use_underline">True</property>
</widget>
<packing>
<property name="left_attach">5</property>
<property name="right_attach">7</property>
<property name="top_attach">9</property>
<property name="bottom_attach">11</property>
<property name="x_options">GTK_FILL</property>
<property name="y_options">GTK_EXPAND</property>
</packing>
</child>
<child>
<widget class="GtkButton" id="print_button">
<property name="label" translatable="yes">Print</property>
<property name="width_request">35</property>
<property name="height_request">45</property>
<property name="visible">True</property>
<property name="can_focus">True</property>
<property name="receives_default">False</property>
<property name="use_underline">True</property>
</widget>
<packing>
<property name="left_attach">1</property>
<property name="right_attach">3</property>
<property name="top_attach">9</property>
<property name="bottom_attach">11</property>
<property name="x_options">GTK_FILL</property>
<property name="y_options">GTK_EXPAND</property>
</packing>
</child>
<child>
<widget class="GtkMenuBar" id="menubar1">
<property name="visible">True</property>
<property name="can_focus">False</property>
<child>
<widget class="GtkMenuItem" id="menuitem1">
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="label" translatable="yes">_File</property>
<property name="use_underline">True</property>
<child>
<widget class="GtkMenu" id="menu1">
<property name="visible">True</property>
<property name="can_focus">False</property>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem1">
<property name="label">gtk-new</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem2">
<property name="label">gtk-open</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem3">
<property name="label">gtk-save</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem4">
<property name="label">gtk-save-as</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkSeparatorMenuItem" id="separatormenuitem1">
<property name="visible">True</property>
<property name="can_focus">False</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem5">
<property name="label">gtk-quit</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
</widget>
</child>
</widget>
</child>
<child>
<widget class="GtkMenuItem" id="menuitem2">
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="label" translatable="yes">_Edit</property>
<property name="use_underline">True</property>
<child>
<widget class="GtkMenu" id="menu2">
<property name="visible">True</property>
<property name="can_focus">False</property>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem6">
<property name="label">gtk-cut</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem7">
<property name="label">gtk-copy</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem8">
<property name="label">gtk-paste</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem9">
<property name="label">gtk-delete</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
</widget>
</child>
</widget>
</child>
<child>
<widget class="GtkMenuItem" id="menuitem3">
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="label" translatable="yes">_View</property>
<property name="use_underline">True</property>
</widget>
</child>
<child>
<widget class="GtkMenuItem" id="menuitem4">
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="label" translatable="yes">_Help</property>
<property name="use_underline">True</property>
<child>
<widget class="GtkMenu" id="menu3">
<property name="visible">True</property>
<property name="can_focus">False</property>
<child>
<widget class="GtkImageMenuItem" id="imagemenuitem10">
<property name="label">gtk-about</property>
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="use_underline">True</property>
<property name="use_stock">True</property>
</widget>
</child>
</widget>
</child>
</widget>
</child>
</widget>
<packing>
<property name="right_attach">9</property>
</packing>
</child>
<child>
<widget class="GtkLabel" id="label1">
<property name="visible">True</property>
<property name="can_focus">False</property>
<property name="label" translatable="yes">Design in Glade read *.ui file in Bacon</property>
</widget>
<packing>
<property name="left_attach">1</property>
<property name="right_attach">7</property>
<property name="top_attach">2</property>
<property name="bottom_attach">3</property>
</packing>
</child>
</widget>
</child>
</widget>
</glade-interface>


```



---


[Back to top of document](#TOP.md)

## GUI-GLADE2BAC ##

![http://bigbass-porteus.googlecode.com/files/GUI-mkglade-proto2.png](http://bigbass-porteus.googlecode.com/files/GUI-mkglade-proto2.png)

|**Example code:  GUI-mkglade-proto.bac**|
|:---------------------------------------|

```

' GUI-mkglade-proto.bac


INCLUDE "hug.bac"
INIT





' =====================
' DECLARATIONS
' =====================

SETENVIRON "OUTPUT_CHARSET", "UTF-8"
OPTION INTERNATIONAL TRUE
GLOBAL reccount TYPE NUMBER
GLOBAL sigcount TYPE NUMBER
GLOBAL hassignal TYPE NUMBER
GLOBAL q$, s$, myline$, myline1$, myline2$, myglade$ TYPE STRING
RECORD glade[1000]
LOCAL class$ TYPE STRING
LOCAL id$ TYPE STRING
LOCAL signal$[100] TYPE STRING
LOCAL handler$[100] TYPE STRING
LOCAL wtype TYPE NUMBER
END RECORD





' =====================
' WINDOW DATA
' =====================
DATA "GtkWindow", "GtkDialog", "GtkInvisible", "GtkMessageDialog", "GtkAboutDialog"
DATA "GtkAssistant", "GtkWindowGroup", "GtkOffscreenWindow", "ENDWIN"
DATA "GtkDialog" ,"GtkWindow" ,"GtkAssistant " ,"GtkLabel " ,"GtkStatusbar "
DATA "GtkInfoBar " ,"GtkStatusIcon " ,"GtkButton " ,"GtkRadioButton " ,"GtkToggleButton "
DATA "GtkScaleButton " ,"GtkEntry " ,"GtkEntryBuffer " ,"GtkEntryCompletion " ,"GtkSpinButton "
DATA "GtkEditable " ,"GtkTextBuffer " ,"GtkTextTag " ,"GtkTextTagTable " ,"GtkTextView "
DATA "GtkTreeModel " ,"GtkTreeSelection " ,"GtkTreeViewColumn " ,"GtkTreeView " ,"GtkIconView "
DATA "GtkTreeSortable " ,"GtkCellRenderer " ,"GtkCellEditable " ,"GtkCellRendererAccel " ,"GtkCellRendererCombo "
DATA "GtkCellRendererText " ,"GtkCellRendererToggle " ,"GtkComboBox " ,"GtkMenu " ,"GtkMenuItem "
DATA "GtkRadioMenuItem " ,"GtkCheckMenuItem " ,"GtkToolbar " ,"GtkToolItem " ,"GtkToolPalette " ,"GtkImageMenuItem"
DATA "GtkToolButton " ,"GtkMenuToolButton " ,"GtkToggleToolButton " ,"GtkUIManager " ,"GtkActionGroup "
DATA "GtkAction " ,"GtkToggleAction " ,"GtkRadioAction " ,"GtkColorButton " ,"GtkColorSelection "
DATA "GtkHSV " ,"GtkFileChooser " ,"GtkFileChooserButton " ,"GtkFontButton " ,"GtkInputDialog "
DATA "GtkLayout" ,"GtkNotebook" ,"GtkExpander" ,"GtkScrolledWindow" ,"GtkPrintOperation"
DATA "GtkPrinter" ,"GtkPrintJob" ,"GtkAdjustment" ,"GtkCalendar" ,"GtkHandleBox"
DATA "GtkViewport" ,"GtkContainer" ,"GtkItem" ,"GtkMenuShell" ,"GtkObject"
DATA "GtkPaned" ,"GtkRange" ,"GtkScale" ,"GtkWidget" ,"GtkIMContext"
DATA "GtkPlug" ,"GtkSocket" ,"GtkCurve" ,"GtkRecentManager" ,"GtkRecentChooser"
DATA "GtkCList" ,"GtkCTree" ,"GtkList" ,"GtkListItem" ,"GtkOldEditable"
DATA "GtkOptionMenu" ,"GtkText" ,"GtkTipsQuery" ,"GtkTree" ,"GtkTreeItem", "ENDSIG"


' =====================
' SUBROUTINES
' =====================

' -------------
SUB INIT_VARS()
' -------------
    q$ = CHR$(34)
    s$ = CHR$(92)
    myline$ = CONCAT$("' ", FILL$(30,45))
    myline1$ = CONCAT$("' ", FILL$(75,42))
    myline2$ = CONCAT$("' ", FILL$(40,42))
    hassignal = 0
END SUB




' --------------------
FUNCTION CAT(STRING FILENAME$)
' --------------------
    LOCAL fileline$, txt$ TYPE STRING
    IF FILEEXISTS(FILENAME$) THEN
        OPEN FILENAME$ FOR READING AS catfile
        WHILE NOT(ENDFILE(catfile)) DO
            READLN fileline$ FROM catfile
            txt$ = CONCAT$(txt$, fileline$, NL$)
        WEND
        CLOSE FILE catfile
    END IF
    RETURN CHOP$(txt$)
END FUNCTION

' -------------
SUB MAKE_READ()
' -------------
    LOCAL i
    gladevar$ = CAT(gladefile$)
    gladevar$ = REPLACE$(gladevar$, q$,CONCAT$(s$,q$))
    SPLIT gladevar$ BY NL$ TO gladearray$ SIZE no_of_lines
    FOR i = 0 TO no_of_lines - 1
        IF LEN(gladearray$[i]) > 1 THEN
            WRITELN CONCAT$("DATA ", q$, gladearray$[i], q$) TO fh1
        END IF
    NEXT i
END SUB

' -------------
SUB READ_GLADE()
' -------------
    OPEN gladefile$ FOR READING AS fh
    reccount = 0
    sigcount = 0
    'glade[reccount].wtype = 0
    WITH glade[reccount]
        .wtype = 0
    END WITH
    WHILE NOT(ENDFILE(fh)) DO
        READLN txt$ FROM fh
        IF NOT(ENDFILE(fh)) THEN
            ' Detect user-defined windows + signals
            idx = INSTR(txt$, "class=")
            IF idx > 0 THEN
                startpos = idx + 7
                endpos = INSTR(txt$, q$, idx + 8)
                WITH glade[reccount]
                    .class$ = MID$(txt$, startpos, endpos - startpos)
                END WITH
                'glade[reccount].class$ = MID$ (txt$, startpos, endpos - startpos)
                REPEAT
                    READ win$
                    IF EQUAL(glade[reccount].class$, CHOP$(win$)) THEN
                        WITH glade[reccount]
                            'wtype 2 means that the widget has a valid signal
                            .wtype = 2
                        END WITH
                    END IF
                UNTIL EQUAL(win$,"ENDSIG")
                RESTORE
            END IF
            idx = INSTR(txt$, "id=")
            IF idx > 0 THEN
                startpos = idx + 4
                endpos = INSTR(txt$, q$, idx +5)
                WITH glade[reccount]
                    .id$ = REPLACE$(MID$(txt$, startpos, endpos - startpos), "-", "_")
                END WITH
                'glade[reccount].id$ = MID$ (txt$, startpos, endpos - startpos)
            END IF
            idx = INSTR(txt$, "signal name=")
            IF idx > 0 THEN
                startpos = idx + 13
                endpos = INSTR(txt$, q$, idx +14)
                WITH glade[reccount]
                    .signal$[sigcount] = MID$(txt$, startpos, endpos - startpos)
                END WITH
                'glade[reccount].signal$[sigcount] = MID$ (txt$, startpos, endpos - startpos)
            END IF
            idx = INSTR(txt$, "handler=")
            IF idx > 0 THEN
                startpos = idx + 9
                endpos = INSTR(txt$, q$, idx +10)
                WITH glade[reccount]
                    .handler$[sigcount] = MID$(txt$, startpos, endpos - startpos)
                END WITH
                'glade[reccount].handler$[sigcount] = MID$ (txt$, startpos, endpos - startpos)
                ' Detect user-defined window elements
                win$ = ""
                REPEAT
                    READ win$
                    IF EQUAL(glade[reccount].class$, win$) THEN
                        WITH glade[reccount]
                            .wtype = 1
                        END WITH
                        'glade[reccount].wtype = 1
                    END IF
                UNTIL EQUAL(win$,"ENDWIN")
                RESTORE
                INCR sigcount
            END IF
            idx = INSTR(txt$, "<child>")
            IF idx > 0 THEN
                INCR reccount
            END IF
        ENDIF
    WEND
    CLOSE FILE fh
END SUB

' -------------
SUB WRITE_BAC()
' -------------
    OPEN CONCAT$(glade_filenameonly$,"_.bac") FOR WRITING AS fh1
    
    
    WRITELN "PRAGMA LDFLAGS `pkg-config --cflags --libs libglade-2.0`" TO fh1
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    WRITELN myline1$ TO fh1
    WRITELN "" TO fh1
    WRITELN "' A utility to read *.glade files and compose callback subs for BaCon." TO fh1
    WRITELN "" TO fh1
    WRITELN "' mekanixx, (Puppy Linux forum) - August 2010" TO fh1
    WRITELN "' vovchik (Puppy Linux forum) - August 2010" TO fh1
    WRITELN "' bigbass (BaCon forum) - April 21 2013 ported to PROTO and PRAGMA " TO fh1
    WRITELN "" TO fh1
    WRITELN CONCAT$("' Created on ", STR$(DAY(NOW)), " ", MONTH$(NOW), " ", STR$(YEAR(NOW))) TO fh1
    WRITELN "" TO fh1
    WRITELN "' Check id= statements in glade data and Reference some widgets section" TO fh1
    WRITELN "' at end for hyphens in function names and references. Change all to underscores!" TO fh1
    WRITELN myline1$ TO fh1
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN CONCAT$("' Callbacks for file: ", gladefile$) TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "' ERROR HANDLING SET UP" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "TRAP LOCAL" TO fh1
    WRITELN "CATCH GOTO print_err" TO fh1
    WRITELN "" TO fh1
    
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "' DECLARATIONS" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    
    
    WRITELN "'==================================" TO fh1
    WRITELN "'--- EMBED GLADE IMPORTS" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "PROTO glade_require" TO fh1
    WRITELN "PROTO glade_provide" TO fh1
    WRITELN "PROTO glade_xml_new" TO fh1
    WRITELN "PROTO glade_xml_new_from_buffer" TO fh1
    WRITELN "PROTO glade_xml_construct" TO fh1
    WRITELN "PROTO glade_xml_construct_from_buffer" TO fh1
    WRITELN "PROTO glade_xml_signal_connect" TO fh1
    WRITELN "PROTO glade_xml_signal_connect_data" TO fh1
    WRITELN "PROTO glade_xml_signal_autoconnect" TO fh1
    WRITELN "PROTO glade_xml_get_widget" TO fh1
    WRITELN "PROTO glade_xml_get_widget_prefix" TO fh1
    WRITELN "PROTO glade_get_widget_name" TO fh1
    WRITELN "PROTO glade_get_widget_tree" TO fh1
    WRITELN "PROTO glade_xml_signal_connect_full" TO fh1
    WRITELN "PROTO glade_xml_signal_autoconnect_full" TO fh1
    WRITELN "PROTO glade_set_custom_handler" TO fh1
    WRITELN "PROTO glade_parser_parse_file" TO fh1
    WRITELN "PROTO glade_parser_parse_buffer" TO fh1
    WRITELN "PROTO glade_interface_destroy" TO fh1
    WRITELN "PROTO glade_interface_dump" TO fh1
    WRITELN "PROTO glade_xml_build_widget" TO fh1
    WRITELN "PROTO glade_xml_handle_internal_child" TO fh1
    WRITELN "PROTO glade_xml_set_common_params" TO fh1
    WRITELN "PROTO glade_register_widget" TO fh1
    WRITELN "PROTO glade_standard_build_widget" TO fh1
    WRITELN "PROTO glade_xml_handle_widget_prop" TO fh1
    WRITELN "PROTO glade_standard_build_children" TO fh1
    WRITELN "PROTO glade_xml_set_packing_property" TO fh1
    WRITELN "PROTO glade_register_custom_prop" TO fh1
    WRITELN "PROTO glade_xml_relative_file" TO fh1
    WRITELN "PROTO glade_enum_from_string" TO fh1
    WRITELN "PROTO glade_flags_from_string" TO fh1
    WRITELN "PROTO glade_xml_set_value_from_string" TO fh1
    WRITELN "PROTO glade_xml_set_toplevel" TO fh1
    WRITELN "PROTO glade_xml_ensure_accel" TO fh1
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    
    
    
    
    WRITELN "'==================================" TO fh1
    WRITELN "'--- EMBED GTK IMPORTS" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN CONCAT$("PROTO ","gtk_main") TO fh1
    WRITELN CONCAT$("PROTO ","gtk_init") TO fh1
    WRITELN CONCAT$("PROTO ","gtk_main_quit") TO fh1
    WRITELN CONCAT$("PROTO ","gtk_widget_show_all") TO fh1
    WRITELN CONCAT$("PROTO ","gtk_exit") TO fh1
    WRITELN CONCAT$("PROTO ","g_signal_connect_data") TO fh1
    WRITELN CONCAT$("PROTO ","g_object_unref") TO fh1
    ' WRITELN CONCAT$("PROTO ","glade_xml_new") TO fh1
    
    WRITELN "" TO fh1
    
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "' GLADE DATA" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "' this is where the DATA statements go" TO fh1
    MAKE_READ
    WRITELN "" TO fh1
    
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "' SUBS & FUNCTIONS" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "SUB READ_DATA()" TO fh1
    WRITELN myline$ TO fh1
    WRITELN CONCAT$(TAB$(1),"gladeline$ = ", q$,q$) TO fh1
    WRITELN CONCAT$(TAB$(1),"REPEAT") TO fh1
    WRITELN CONCAT$(TAB$(2),"READ gladeline$") TO fh1
    WRITELN CONCAT$(TAB$(2), "gladedata$ = CONCAT$(gladedata$, gladeline$)") TO fh1
    WRITELN CONCAT$(TAB$(1),"UNTIL EQUAL(gladeline$, ",q$,"</glade-interface>",q$,")") TO fh1
    WRITELN "END SUB" TO fh1
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "SUB EXIT_PROG()" TO fh1
    WRITELN myline$ TO fh1
    WRITELN CONCAT$(TAB$(1),"gtk_main_quit") TO fh1
    WRITELN "END SUB" TO fh1
    WRITELN "" TO fh1
    FOR idx = 0 TO reccount - 1
        FOR ixh = 0 TO sigcount - 1
            IF NOT(LEN(glade[idx].signal$[ixh]) EQ 0) THEN
            WRITELN "" TO fh1
            WRITELN myline$ TO fh1
            WRITELN CONCAT$("SUB ", glade[idx].handler$[ixh]) TO fh1
            WRITELN myline$ TO fh1
            IF glade[idx].wtype EQ 1 THEN
                IF EQUAL("destroy",glade[idx].signal$[ixh]) OR EQUAL("destroy_event",glade[idx].signal$[ixh]) THEN
                    WRITELN CONCAT$(TAB$(1), "gtk_main_quit") TO fh1
                END IF
            ELSE
                WRITELN CONCAT$(TAB$(1), "' Place your code here") TO fh1
            END IF
            WRITELN CONCAT$(TAB$(1), "' code for signal ", glade[idx].signal$[ixh]) TO fh1
            WRITELN CONCAT$(TAB$(1), "PRINT ", q$, glade[idx].signal$[ixh] ,q$) TO fh1
            WRITELN "END SUB" TO fh1
            END IF
        NEXT ixh
    NEXT idx
    WRITELN "" TO fh1
    
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "' MAIN" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "READ_DATA" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' Initialize Gtk" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "gtk_init(0, 0) " TO fh1
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' Specify the windows to be shown" TO fh1
    WRITELN myline$ TO fh1
    WRITELN CONCAT$("xml = glade_xml_new_from_buffer(gladedata$,LEN(gladedata$)",", 0, 0 )") TO fh1
    ' WRITELN " glade_xml_signal_autoconnect( xml )" TO fh1
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' Reference some widgets" TO fh1
    WRITELN myline$ TO fh1
    FOR ix = 0 TO reccount - 1
        IF glade[ix].wtype EQ 1 THEN
            WRITELN CONCAT$(glade[ix].id$, " = glade_xml_get_widget( xml, ", q$,glade[ix].id$,q$, ")") TO fh1
            FOR ixs = 0 TO sigcount - 1
            IF NOT(LEN(glade[ix].signal$[ixs]) EQ 0) THEN
                WRITELN CONCAT$("g_signal_connect_data(",glade[ix].id$,", ",q$,glade[ix].signal$[ixs],q$,", ", glade[ix].handler$[ixs],", 0, 0, 0)") TO fh1
                END IF
            NEXT ixs
        END IF
    NEXT ix
    WRITELN "" TO fh1
    FOR ix = 0 TO reccount - 1
        IF glade[ix].wtype EQ 2 THEN
        IF NOT(LEN(glade[ix].id$) EQ 0) THEN
            WRITELN CONCAT$(glade[ix].id$, " = glade_xml_get_widget( xml, ", q$,glade[ix].id$,q$, ")") TO fh1
        END IF
        END IF
    NEXT ix
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' Connect some signals " TO fh1
    WRITELN myline$ TO fh1
    FOR idx = 0 TO reccount - 1
        IF glade[idx].wtype EQ 2 THEN
            FOR ixs = 0 TO sigcount - 1
            IF NOT(LEN(glade[idx].signal$[ixs]) EQ 0) THEN
                WRITELN CONCAT$("g_signal_connect_data(",glade[idx].id$,", ",q$,glade[idx].signal$[ixs],q$,", ", glade[idx].handler$[ixs],", 0, 0, 0)") TO fh1
            END IF
            NEXT ixs
        END IF
    NEXT idx
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' Display main window(s)" TO fh1
    WRITELN myline$ TO fh1
    ' Display windows
    FOR ix = 0 TO reccount - 1
        IF glade[ix].wtype EQ 1 THEN
            WRITELN CONCAT$("gtk_widget_show_all( ",glade[ix].id$,")") TO fh1
        END IF
    NEXT ix
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' unattach xml reference" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "g_object_unref( xml )" TO fh1
    WRITELN "" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "' The main GUI loop starts" TO fh1
    WRITELN myline$ TO fh1
    WRITELN "gtk_main " TO fh1
    'WRITELN "END" TO fh1
    WRITELN "" TO fh1
    WRITELN "" TO fh1
    
    WRITELN "" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "' ERROR HANDLER" TO fh1
    WRITELN "'==================================" TO fh1
    WRITELN "" TO fh1
    WRITELN "LABEL print_err" TO fh1
    WRITELN CONCAT$(TAB$(1), "IF ERROR THEN PRINT ERR$(ERROR)") TO fh1
    WRITELN "" TO fh1
    
    WRITELN "" TO fh1
    CLOSE FILE fh1
END SUB



' -------------
SUB entry_demo()
' -------------
    'clear the edit box
    TEXT(EDIT_BOX, "")
    
    ORIGINAL_FILE$ = CHOP$(GRAB$(My_entry))
    file_start$ = "file:///"
    'get rid of drag n drop prefixed file://
    
    IF REGEX(ORIGINAL_FILE$ , file_start$) THEN
        ORIGINAL_FILE$ = REPLACE$(ORIGINAL_FILE$ , file_start$, "/")
        
    ELSE
        ORIGINAL_FILE$ = CHOP$(GRAB$(My_entry))
        
    ENDIF
    

    ORIG$ = ORIGINAL_FILE$
    

    ' Get the string to convert
    gladefile$ = ORIG$
    glade_filenameonly$ = LEFT$(gladefile$, INSTR(gladefile$, ".") - 1)
    PRINT gladefile$
    PRINT glade_filenameonly$

    INIT_VARS
    READ_GLADE
    WRITE_BAC
    
        
        
    '--- the filtered or unfiltered file gets passed here
        
    '--- get the display info using a system call ---'

    result_input2$ = EXEC$(CONCAT$("cat", " ", glade_filenameonly$ ,"_.bac" ))
    

    TEXT(EDIT_BOX, result_input2$)
END SUB



Mainwin = WINDOW( "GUI mkglade-proto ", 700, 450 )


My_entry = ENTRY("", 450, 30)
ATTACH( Mainwin, My_entry, 20, 40 )
CALLBACK(My_entry, entry_demo)


My_label = MARK( "Drag file name here to convert", 300, 30 )
ATTACH( Mainwin, My_label, -10, 10)
FONT(My_label, "sans 12")


My_label = MARK( "converted code shown in the box", 300, 30 )
ATTACH( Mainwin, My_label, 0, 90)
FONT(My_label, "sans 12")

' formatting changes if you use another label name
My_label = MARK( "with _.bac added ", 300, 30 )
ATTACH( Mainwin, My_label, -40 ,110)
FONT(My_label, "sans 12")


EDIT_BOX = EDIT(650, 250)
ATTACH( Mainwin, EDIT_BOX, 20, 140 )


My_btn = STOCK("gtk-convert", 80, 25)
ATTACH( Mainwin, My_btn, 490, 415 )
CALLBACK( My_btn, entry_demo)


' Create a button.
My_chk = STOCK("gtk-quit", 80, 25)
ATTACH( Mainwin, My_chk, 605, 415 )

' Make button do something
CALLBACK( My_chk, QUIT)


DISPLAY

```




[Back to top of document](#TOP.md)

## GOO-CANVAS ##

Thanks to 2lss for this example
depends on the  goo library

original source code
https://developer.gnome.org/goocanvas/unstable/goocanvas-simple-canvas.html

|**Example code: goo-canvas-proto.bac**|
|:-------------------------------------|

```
PRAGMA INCLUDE goocanvas-1.0/goocanvas.h
PRAGMA LDFLAGS `pkg-config --libs --cflags gtk+-2.0 goocanvas`

' goocanvas
PROTO goo_canvas_get_root_item, goo_canvas_item_rotate, goo_canvas_item_request_update, goo_canvas_new
PROTO goo_canvas_rect_new, goo_canvas_set_bounds, goo_canvas_text_new

' gtk
PROTO gtk_container_add, gtk_init, gtk_main, gtk_scrolled_window_new, gtk_scrolled_window_set_shadow_type, gtk_set_locale
PROTO gtk_widget_set_size_request, gtk_widget_show, gtk_window_new, gtk_window_set_default_size

' gobject
PROTO g_signal_connect_data

SUB on_rect_button_press ()
    PRINT "rect item received button press event"
END SUB

SUB on_delete_event ()
    END
END SUB

GLOBAL *window, *scrolled_win, *canvas TYPE GtkWidget
GLOBAL *root, *rect_item, *text_item TYPE GooCanvasItem

gtk_init(0, 0)

window = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_default_size (GTK_WINDOW(window), 640, 600)
gtk_widget_show (window)

scrolled_win = gtk_scrolled_window_new (0, 0)
gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW(scrolled_win), GTK_SHADOW_IN)
gtk_widget_show (scrolled_win)

gtk_container_add (GTK_CONTAINER(window), scrolled_win)

canvas = goo_canvas_new ()
gtk_widget_set_size_request (canvas, 600, 450)
goo_canvas_set_bounds (GOO_CANVAS(canvas), 0, 0, 1000, 1000)
gtk_widget_show (canvas)
gtk_container_add (GTK_CONTAINER(scrolled_win), canvas)

root = goo_canvas_get_root_item (GOO_CANVAS(canvas))

rect_item = goo_canvas_rect_new (root, 100, 100, 400, 400, "line-width", 10.0, "radius-x", 20.0, "radius-y", 10.0, "stroke-color", "yellow", "fill-color", "red", 0)

text_item = goo_canvas_text_new (root, "Hello World", 300, 300, -1, GTK_ANCHOR_CENTER, "font", "Sans 24", 0)
goo_canvas_item_rotate (text_item, 45, 300, 300)

g_signal_connect_data (rect_item, "button_press_event", (GtkSignalFunc) on_rect_button_press, 0, 0, 0)
g_signal_connect_data (window, "delete_event", (GtkSignalFunc) on_delete_event, 0, 0, 0)

gtk_main()
```




[Back to top of document](#TOP.md)


## FILECHOOSER ##

![http://bigbass-porteus.googlecode.com/files/filechooser-gtk3-proto.png](http://bigbass-porteus.googlecode.com/files/filechooser-gtk3-proto.png)

|**Example code: filechooser-gtk3-proto.bac**|
|:-------------------------------------------|

```
PRAGMA LDFLAGS pkg-config --cflags --libs gtk+-3.0

PROTO gtk_file_chooser_dialog_new
PROTO gtk_dialog_run
PROTO gtk_file_chooser_get_filename
PROTO gtk_widget_destroy
PROTO gtk_init
PROTO gtk_main
PROTO g_signal_connect_data
PROTO gtk_main_quit
PROTO g_timeout_add 



'--- low level button signals 
CONST GTK_RESPONSE_OK = -5
CONST GTK_RESPONSE_CANCEL = -6
CONST GTK_RESPONSE_CLOSE = -7
CONST GTK_RESPONSE_DELETE_EVENT = -4
CONST GTK_RESPONSE_ACCEPT = -3 
CONST GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER = 3
CONST GTK_FILE_CHOOSER_ACTION_OPEN = 0
CONST GTK_FILE_CHOOSER_ACTION_SAVE = 1
CONST GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER = 2
CONST GTK_STOCK_CANCEL = "gtk-cancel"
CONST GTK_STOCK_OPEN = "gtk-open"




'=====================
FUNCTION exit_prog
'=====================

	PRINT "HERE"
	gtk_main_quit

	RETURN TRUE
END FUNCTION



'=====================
SUB file_ok_sel()
'=====================
'--- Get the selected filename and print it to the console

	PRINT "you got to the call back file_ok_sel"
	filename$ =(char *) gtk_file_chooser_get_filename (dialog)
	PRINT filename$ 
END SUB



gtk_init (0, 0)

dialog = gtk_file_chooser_dialog_new ("Open File", \
					dialog, \
					GTK_FILE_CHOOSER_ACTION_OPEN, \
					GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL, \
					GTK_STOCK_OPEN, GTK_RESPONSE_ACCEPT, \
					NULL)




'--- GTK_RESPONSE_ACCEPT
'--- major work around to connect buttons using the reponses 
'--- after a modified callback using just the callback name 

IF gtk_dialog_run(dialog) = GTK_RESPONSE_ACCEPT  THEN
	filename = gtk_file_chooser_get_filename (dialog)
	PRINT "The low level OK button was pressed "    
	file_ok_sel
END IF




'--- GTK_RESPONSE_CANCEL
'--- major work around to connect buttons using the reponses 
'--- after a modified callback using just the callback name 
IF gtk_dialog_run(dialog ) = GTK_RESPONSE_CANCEL  THEN
	PRINT "The low level CANCEL button was pressed "
	PRINT "close main window"    
	exit_prog    
END IF



g_signal_connect_data(dialog, "destroy", exit_prog, 0, 0, 0)
g_timeout_add(500, exit_prog, NULL)
gtk_widget_destroy (dialog)
gtk_main 

PRINT "The top level window of the application was closed...Exiting the program"

```




[Back to top of document](#TOP.md)

## FSELECT ##

![http://bigbass-porteus.googlecode.com/files/fileselect-fixed.png](http://bigbass-porteus.googlecode.com/files/fileselect-fixed.png)

|**Example code: fsel-gtk2-proto.bac**|
|:------------------------------------|

```

PRAGMA LDFLAGS pkg-config --cflags --libs gtk+-2.0

PROTO gtk_file_selection_set_filename
PROTO gtk_init
PROTO gtk_main
PROTO gtk_widget_show
PROTO gtk_file_selection_new
PROTO g_signal_connect_data
PROTO gtk_main_quit
PROTO gtk_dialog_run
PROTO gtk_widget_destroy
PROTO g_timeout_add
PROTO gtk_exit

'--- low level button signals
CONST GTK_RESPONSE_OK = -5
CONST GTK_RESPONSE_CANCEL = -6
CONST GTK_RESPONSE_CLOSE = -7
CONST GTK_RESPONSE_DELETE_EVENT = -4


'=====================
SUB exit_prog()
'=====================

    PRINT "HERE"
    gtk_exit(0)
END SUB

'=====================
SUB file_ok_sel()
'=====================
    '--- Get the selected filename and print it to the console

    PRINT "you got to the call back file_ok_sel"
    selected$ = (char *)gtk_file_selection_get_filename (filew)
    PRINT selected$
END SUB



gtk_init (0, 0)

'--- Create a new file selection widget
filew = gtk_file_selection_new ("File selection")




'--- Lets set the filename, as if this were a save dialog, and we are giving a default filename
gtk_file_selection_set_filename (filew, "penguin.png")

'--- GTK_RESPONSE_OK
'--- major work around to connect buttons using the reponses
'--- after a modified callback using just the callback name
IF gtk_dialog_run(filew ) = GTK_RESPONSE_OK THEN
    PRINT "The low level OK button was pressed "
    CALL file_ok_sel
END IF



'--- GTK_RESPONSE_CANCEL
'--- major work around to connect buttons using the reponses
'--- after a modified callback using just the callback name
IF gtk_dialog_run(filew ) = GTK_RESPONSE_CANCEL THEN
    PRINT "The low level CANCEL button was pressed "
    PRINT "close main window"
    CALL exit_prog

END IF

g_signal_connect_data(filew, "destroy", exit_prog, 0, 0, 0)



gtk_widget_show (filew)
gtk_main

PRINT "The top level window of the application was closed...Exiting the program"
```



[Back to top of document](#TOP.md)

## HSCALE ##

![http://bigbass-porteus.googlecode.com/files/scale-proto.png](http://bigbass-porteus.googlecode.com/files/scale-proto.png)

|**Example code: hscale-gtk2-proto.bac**|
|:--------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`

'--- 
'---  GTK example with BACON
'---  March 2009 - PvE.
'---  Adapted November 2009. adapted for Hscale 2013 alexfish
'---  Ported to PROTO/PRAGMA/IMPORT syntax 2013 bigbass


'---  Get needed functions from GTK

PROTO gtk_table_attach_defaults
PROTO gtk_window_set_title
PROTO gtk_button_new_from_stock
'PROTO gtk_range_get_value
PROTO gtk_table_new
PROTO gtk_window_new
PROTO gtk_container_add
PROTO gtk_exit
'PROTO gtk_hscale_new_with_range
PROTO gtk_init
PROTO gtk_label_new
PROTO gtk_widget_show_all
PROTO gtk_main

PROTO g_signal_connect_data

'----------------------------------------------------
' get around low level pointers  USING IMPORT
'----------------------------------------------------
CONST Gtk$ = "libgtk-x11-2.0.so.0"


'-- Get needed functions from GTK using IMPORT
IMPORT "gtk_hscale_new_with_range(double,double,double)" FROM Gtk$ TYPE long
IMPORT "gtk_range_get_value(long)" FROM Gtk$ TYPE double

'----------------------------------------------------

'---  Callback for closing window
SUB exit_prog
	PRINT "QUIT"
	gtk_exit(0)
	
END SUB



SUB Changed
	LOCAL get
	get = gtk_range_get_value( Hscale )
	PRINT " CHANGED ",get
END SUB

'--- Main program starts here
gtk_init(0, 0)

window = gtk_window_new(0)

gtk_window_set_title(window, "scale PROTO")
table = gtk_table_new(15, 15, 1)
gtk_container_add(window, table)    
Hscale = gtk_hscale_new_with_range(0,1000,1)


button = gtk_button_new_from_stock("gtk-quit")

gtk_table_attach_defaults(table, button, 10, 14, 12, 14)
gtk_table_attach_defaults(table,Hscale, 1, 14, 3, 14)

'--- Use as callback the defined SUB
g_signal_connect_data(button, "clicked",exit_prog, 0, 0, 0)
g_signal_connect_data(Hscale, "value-changed", Changed ,0, 0, 0)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)


'--- Show whole GUI
gtk_widget_show_all(window)

gtk_main

```


[Back to top of document](#TOP.md)

## SCROLLED ##

![http://bigbass-porteus.googlecode.com/files/scrolled-proto.png](http://bigbass-porteus.googlecode.com/files/scrolled-proto.png)

|**Example code: scrolled-gtk3-proto.bac**|
|:----------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`
PRAGMA INCLUDE gtk-3.0/gtk/gtk.h

'image used
'http://bigbass-porteus.googlecode.com/files/images.jpeg

PROTO gtk_container_add
PROTO gtk_container_set_border_width
PROTO gtk_scrolled_window_add_with_viewport
PROTO gtk_scrolled_window_set_policy
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_title
PROTO gtk_image_new_from_file
PROTO gtk_scrolled_window_new
PROTO gtk_window_new

PROTO gtk_init
PROTO gtk_main
PROTO g_signal_connect_data
PROTO gtk_main_quit

'--- Declare variables
DECLARE *window, *scrolled_window, *image TYPE GtkWidget


'=====================
SUB exit_prog
'=====================
    gtk_main_quit
END SUB


gtk_init (0,0)
'--- Create a window with a title, and a default size
window = gtk_window_new (0)
gtk_window_set_title (GTK_WINDOW (window), "Scrolled Window Example")
gtk_window_set_default_size (GTK_WINDOW (window), 230, 200)
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)

'--- Create the scrolled window. Usually 0 is passed for both parameters so
'--- that it creates the horizontal/vertical adjustments automatically. Setting
'--- the scrollbar policy to automatic allows the scrollbars to only show up
'--- when needed.

scrolled_window = gtk_scrolled_window_new (0, 0)
'--- Set the border width
gtk_container_set_border_width (GTK_CONTAINER (scrolled_window), 10)
'--- Extract our desired image from a file that we have
image = gtk_image_new_from_file ("images.jpeg")
'--- And add it to the scrolled window
gtk_scrolled_window_add_with_viewport (GTK_SCROLLED_WINDOW (scrolled_window), image)
'--- Set the policy of the horizontal and vertical scrollbars to automatic.
'--- What this means is that the scrollbars are only present if needed.

gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window), \
GTK_POLICY_AUTOMATIC, \
GTK_POLICY_AUTOMATIC)

gtk_container_add (GTK_CONTAINER (window), scrolled_window)

gtk_widget_show_all (window)

gtk_main
```




[Back to top of document](#TOP.md)

## KEYPRESSED ##

gets key pressed and displays it in terminal
and in the title
**mouse must stay in the window to catch the event**

[http://]

|**Example code: keypressed-gtk2-proto.bac**|
|:------------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-2.0`
PRAGMA INCLUDE gtk-2.0/gtk/gtk.h

'--- GTK
PROTO gtk_init
PROTO gtk_main
PROTO gtk_widget_show
PROTO gtk_window_new
PROTO gtk_exit
PROTO gtk_window_set_title

'---extras
PROTO g_signal_connect_data
PROTO g_printerr

'--- GDK
PROTO gdk_keyval_name


'--- Declare variables
DECLARE *window TYPE GtkWidget
DECLARE *event TYPE GdkEventKey


FUNCTION key_event(GtkWidget *widget, GdkEventKey *event)

    g_printerr("%s\n", gdk_keyval_name (event->keyval))

    keypressed$ = gdk_keyval_name (event->keyval)
    gtk_window_set_title(GTK_WINDOW(window), keypressed$ )
    RETURN FALSE
END FUNCTION



'--- Callback for closing window
SUB exit_prog
    PRINT "QUIT"
    gtk_exit(0)
END SUB




gtk_init (0, 0)
window = gtk_window_new (GTK_WINDOW_TOPLEVEL)
gtk_window_set_title(GTK_WINDOW(window), "get key press")

'--- Use as callback the defined SUB/FUNCTIONS
g_signal_connect_data(window, "delete-event", exit_prog, 0, 0, 0)
g_signal_connect_data(window, "key-release-event", G_CALLBACK(key_event) ,0, 0, 0)
gtk_widget_show (window)
gtk_main

```




[Back to top of document](#TOP.md)

## NOTYET ##

[http://]

|**Example code: notyet.bac**|
|:---------------------------|

```

```




[Back to top of document](#TOP.md)

## NOTYET ##

[http://]

|**Example code: notyet.bac**|
|:---------------------------|

```

```




[Back to top of document](#TOP.md)

## H&VSCALE ##



![http://bigbass-porteus.googlecode.com/files/scale-gtk3.png](http://bigbass-porteus.googlecode.com/files/scale-gtk3.png)

I ported this from the official GTK3 example from gnome

**thanks alexfish for adding the callbacks to the code example**


|**Example code: slider-gtk3-proto.bac**|
|:--------------------------------------|

```
PRAGMA LDFLAGS `pkg-config --cflags --libs gtk+-3.0`
PRAGMA INCLUDE gtk-3.0/gtk/gtk.h

PROTO gtk_label_set_text
PROTO gtk_container_add
PROTO gtk_container_set_border_width
PROTO gtk_grid_attach
PROTO gtk_grid_set_column_homogeneous
PROTO gtk_grid_set_column_spacing
PROTO gtk_scale_set_digits
PROTO gtk_widget_set_hexpand
PROTO gtk_widget_set_valign
PROTO gtk_widget_set_vexpand
PROTO gtk_widget_show_all
PROTO gtk_window_set_default_size
PROTO gtk_window_set_title
PROTO gtk_adjustment_new
PROTO gtk_application_new
PROTO gtk_window_new
PROTO gtk_grid_new
PROTO gtk_label_new
PROTO gtk_range_get_value
PROTO gtk_scale_new

'--- added after
PROTO gtk_init
PROTO gtk_main
PROTO g_signal_connect_data
PROTO gtk_main_quit
PROTO gtk_scale_get_value_pos
PROTO gtk_range_get_value

PROTO gtk_scale_set_digits
PROTO gtk_adjustment_get_value


'--- Declare variables
GLOBAL *window TYPE GtkWidget
GLOBAL *h_scale TYPE GtkWidget
GLOBAL *v_scale TYPE GtkWidget
GLOBAL *hlabel TYPE GtkWidget
GLOBAL *vlabel TYPE GtkWidget
GLOBAL *grid TYPE GtkWidget


GLOBAL *scale TYPE GtkPositionType
GLOBAL *pos TYPE GtkPositionType


'--- The Adjustment object represents a value
'--- which has an associated lower and upper bound.
GLOBAL *Hscale_adjustment TYPE GtkAdjustment
GLOBAL *Vscale_adjustment TYPE GtkAdjustment


'--- This is the callback function. It is a handler function which
'--- reacts to the signal. with hscale and vscale

'==============
SUB get_bits_hscale
'==============
    LOCAL val TYPE double
    val=gtk_adjustment_get_value(Hscale_adjustment)
    PRINT val
END SUB




'==============
SUB get_bits_vscale
'==============
    LOCAL val TYPE double
    val=gtk_adjustment_get_value(Vscale_adjustment)
    PRINT val
END SUB



'==============
SUB EXIT_PROG
'==============
    gtk_main_quit
END SUB


gtk_init(0, 0)


'--- Create a window with a title and a default size
window = gtk_window_new (0)
gtk_window_set_title (GTK_WINDOW (window), "Scale Example GTK3")
gtk_window_set_default_size (GTK_WINDOW (window), 400, 300)
gtk_container_set_border_width (GTK_CONTAINER (window), 5)
'---Connecting the clicked signal to the callback function
g_signal_connect_data(window, "destroy", EXIT_PROG, 0, 0, 0)

'--- Two labels to be shown in the window
hlabel = gtk_label_new ("Move the scale handle...")
vlabel = gtk_label_new ("Move the scale handle...")


'--- gtk_adjustment_new takes six parameters, three of which
'--- may be difficult to understand:
'--- step increment- move the handle with the arrow keys on your keyboard to see.
'--- page increment - move the handle by clicking away from it
'--- on the scale to see.
'--- page size - not used here.

Hscale_adjustment = gtk_adjustment_new((double)0,(double)0,(double)100,(double)5,(double)10,(double)0)

Vscale_adjustment = gtk_adjustment_new((double)0,(double)0,(double)100,(double)5,(double)10,(double)0)

'--- Create the Horizontal scale, making sure the
'---digits used have no decimals.

h_scale = gtk_scale_new (GTK_ORIENTATION_HORIZONTAL, Hscale_adjustment)
gtk_scale_set_digits (GTK_SCALE (h_scale), 0)


'--- Allow it to expand horizontally (if there's space), and
'--- set the vertical alignment

gtk_widget_set_hexpand (h_scale, TRUE)
gtk_widget_set_valign (h_scale, GTK_ALIGN_START)

'--- Connecting the "value-changed" signal for the horizontal scale
'--- to the appropriate callback function.
'---take note that GtkRange is part of GtkScale's Object Hierarchy.



g_signal_connect_data (h_scale, "value-changed", get_bits_hscale, 0, 0, 0)

'--- Create the Vertical scale. This time, we will see what happens
'--- when the digits arent initially set.


v_scale = gtk_scale_new (GTK_ORIENTATION_VERTICAL, Vscale_adjustment)
gtk_scale_set_digits (GTK_SCALE (v_scale), 0)

gtk_widget_set_vexpand (v_scale, TRUE)

'--- Connecting the "value-changed" signal for the vertical scale to
'--- the appropriate callback function.

g_signal_connect_data (v_scale, "value-changed", get_bits_vscale, 0, 0, 0)

'--- Create a grid and arrange everything accordingly
grid = gtk_grid_new ()
gtk_grid_set_column_spacing (GTK_GRID (grid), 10)
gtk_grid_set_column_homogeneous (GTK_GRID (grid), TRUE)
gtk_grid_attach (GTK_GRID (grid), h_scale, 0, 0, 1, 1)
gtk_grid_attach (GTK_GRID (grid), v_scale, 1, 0, 1, 1)
gtk_grid_attach (GTK_GRID (grid), hlabel, 0, 1, 1, 1)
gtk_grid_attach (GTK_GRID (grid), vlabel, 1, 1, 1, 1)


gtk_container_add (GTK_CONTAINER (window), grid)

gtk_widget_show_all (window)

gtk_main 
```




[Back to top of document](#TOP.md)

## NOTYET ##

[http://]

|**Example code: notyet.bac**|
|:---------------------------|

```

```




[Back to top of document](#TOP.md)