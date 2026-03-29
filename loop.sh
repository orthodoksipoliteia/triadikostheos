#!/usr/bin/env bash
set -e

dir="generated"
mkdir -p "$dir"

# total target in bytes (1 GB)
total_target=$((5*1024*1024*1024))  
total_size=0

# create initial random chunk (~4 MB)
chunk="chunk.txt"
awk 'BEGIN {
    srand()
    s1="Κύριε Ιησού Χριστέ, ελέησον με\n"
    s2="Δόξα σοι ὁ Θεός\n"
    for(i=0;i<500000;i++) {  # smaller chunk ~0.4 MB for demonstration
        if(rand()<0.5) printf s1
        else printf s2
    }
}' > "$chunk"

chunk_bytes=$(wc -c < "$chunk")
echo "Chunk size: $chunk_bytes bytes"

# generate one file
filename=$(LC_CTYPE=C tr -dc '0-9' </dev/urandom | head -c 10)
outfile="$dir/$filename.txt"
echo "Generating $outfile"

bytes_written=0
> "$outfile"

while [ $bytes_written -lt $total_target ]; do
    # calculate remaining bytes for this write
    remaining=$((total_target - bytes_written))
    # if chunk larger than remaining, use head to trim
    if [ $chunk_bytes -gt $remaining ]; then
        head -c $remaining "$chunk" >> "$outfile"
        bytes_written=$total_target
    else
        cat "$chunk" >> "$outfile"
        bytes_written=$((bytes_written + chunk_bytes))
    fi
done

echo "Finished $outfile, size: $(wc -c < "$outfile") bytes"