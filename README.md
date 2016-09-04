# Patch9ProgressBar
A more customizable alternative to standard ProgressBar nodes.  

 
**Requirements:** Godot Engine 2.1 or higher  

**Installation:** Copy the 'addons' folder into your Godot Engine project folder. You should now see an option for Patch9ProgressBar when you add a new node to your scenes.  

**Usage:** The Patch9ProgressBar node has the following custom parameters:  
-display_info: Displays text over the progressbar. None (no text), Percent (50%), or Amount (50/100)  
-display_info_font: The font to be used for text display  
-progress_bar_alignment: Set how the progress bar is aligned. "Left" (empty to left), "Right" (empty to right), "Center" (shrink toward center)  
-progress_bar_direction: Set whether the progress bar is filling horizontally or vertically (NOT IMPLEMENTED YET)  
-under_image/over_image/progress_image: Identical to TextureProgress  
-.._patch_margin: Patch9 margins for under/over/progress images. A 4-entry Array for left/top/right/bottom margins.  
