#!/bin/sh

if hash wandb 2> /dev/null; then
    wandb login
    ENABLE_WANDB=True
else
    ENABLE_WANDB=False
fi

# Use half the CPU cores so cloudwriter can use other half
img2dataset \
    --url_list ~/laion-400M/laion400m-meta \
    --input_format parquet \
    --url_col URL \
    --caption_col TEXT \
    --output_format parquet \
    --output_folder /tmp/laion2b-processed \
    --processes_count 48 \
    --thread_count 96 \
    --resize_mode no \
    --save_additional_columns '["NSFW","similarity","LICENSE"]' \
    --enable_wandb True \
    --wandb_project laion-dataset

touch /tmp/laion2b-processed/done
