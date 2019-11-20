#### Benedikt Kretzmeyer - current version: 11.11.2019

#### Decision-Making and how it as affected by Cognitive Workload in a Lane Merging Task. 
#### A fMRI driving simulator study

### Script is supposed to:
### - calibrate and control eyetracker
### - play video
### - play nback soundfile
### - record button presses and compare them to the expected button presses

## settings

# default path for stimuli - needs to be changed accordingly
default_path = "C:\\Users\\zuse\\OneDrive - FernUniversität Hagen\\Masterarbeit_Data\\presentationtest";

# Define default settings
default_font = "Times New Roman";
default_font_size = 25;
default_text_color = 200,200,200;
default_formatted_text = true;
default_background_color = 35,40,40;

# buttons
active_buttons 	  = 3;
button_codes        = 1,2,3;
target_button_codes = 101,102,103;
response_matching = simple_matching;

## SDL Part

# begin
begin;

# define stimuli



# define trials

trial {
	# nothing stimulus required for parallel stimulus events
	nothing {}; 
	# play entire video
	video { filename = "newtest1_vd.avi"; } vid1;
	# play sound as long as video
	sound { wavefile { filename = "nback1_nr_1.wav"; }; } sound1;
	parallel = true;
} trialvideo1;

trial {
# play entire video
	video { filename = "newtest2_vd.avi"; } vid2;
} trialvideo2;

begin_pcl;

trialvideo1.present();
trialvideo2.present();
