#!/bin/sh

if hash wandb 2> /dev/null; then
    wandb login
    ENABLE_WANDB=True
else
    ENABLE_WANDB=False
fi

# Use half the CPU cores so cloudwriter can use other half
img2dataset \
    --url_list ~/coyo-700m/data \
    --input_format parquet \
    --url_col "url" \
    --caption_col "text" \
    --output_format parquet \
    --image_size=768 \
    --resize_only_if_bigger=True \
    --output_folder /tmp/coyo-processed \
    --processes_count 32 \
    --thread_count 64 \
    --resize_mode "keep_ratio" \
    --save_additional_columns '["clip_similarity_vitb32","clip_similarity_vitl14","nsfw_score_opennsfw2","nsfw_score_gantman","watermark_score","aesthetic_score_laion_v2"]' \
    --enable_wandb True \
    --wandb_project coyo-dataset

touch /tmp/coyo-processed/done
