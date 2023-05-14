#!/bin/sh

if hash wandb 2> /dev/null; then
    	wandb login
	ENABLE_WANDB=True
else
	 ENABLE_WANDB=False
fi


img2dataset --url_list ~/cc12m/cc12m.tsv \
	--input_format "tsv"\
        --url_col "url" \
	--caption_col "caption" \
	--output_format parquet \
	--output_folder /tmp/cc12m-processed \
	--processes_count 16 \
	--thread_count 64 \
	--image_size 256 \
        --enable_wandb True \
   	--resize_mode no 
