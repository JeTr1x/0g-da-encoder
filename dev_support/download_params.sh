#!/bin/bash

mkdir -p ./params
cd ./params

set -e

# Generated by GPT-4
# Function to verify and download a file based on provided hash
# $1: Filename
# $2: Expected SHA256 hash
checked_download() {
    local filename=$1
    local expected_hash=$2
    local url="https://da-encoder-params.s3.ap-northeast-3.amazonaws.com/$filename"

    # Check if the file already exists
    if [ -f "$filename" ]; then
        echo "File $filename exists. Verifying hash..."
        local actual_hash=$(sha256sum "$filename" | awk '{print $1}')
        
        # Check if the existing file has the correct hash
        if [ "$actual_hash" == "$expected_hash" ]; then
            echo "Hash verification successful."
            return 0
        else
            echo "Hash mismatch. Expected $expected_hash, but found $actual_hash. Redownloading..."
        fi
    else
        echo "File $filename does not exist. Downloading..."
    fi

    # Download the file
    curl "$url" -o "$filename"

    # Verify the hash of the downloaded file
    actual_hash=$(sha256sum "$filename" | awk '{print $1}')
    if [ "$actual_hash" != "$expected_hash" ]; then
        echo -e "\033[31mERROR: Hash verification failed after download. Expected $expected_hash, but found $actual_hash. Exiting...\033[0m"
        exit 1
    else
        echo "File downloaded and verified successfully."
    fi
}


checked_download amt-verify-coset0-5DWgDV-10-20.bin 18bb6b7ba10785a79810180ddd27a6d467d2c0e24e6335e5bc95998e02c6a4f6
checked_download amt-verify-coset1-5DWgDV-10-20.bin 19b024fed13e0ba60b17184c998dcccf12119b4fd0ab7c46394b8e024e99c48a
checked_download amt-verify-coset2-5DWgDV-10-20.bin 5660a89402df7d47885b304b566d92e1c42349744e202d45fc61a0893bd796c9

checked_download amt-prove-coset0-mont-5DWgDV-10-20.bin 6c1d7837e5380ca7e09e1f396b4f8ff3ec546cabcccc7bc65f6439a75a791a80
checked_download amt-prove-coset1-mont-5DWgDV-10-20.bin a9f4f6b07a0d66620d652227233c42d12d2726c00f802eadd0e46db68917885a
checked_download amt-prove-coset2-mont-5DWgDV-10-20.bin 0314657436c124f2b00c7bb4e239dc551ab4f0f732516ad9dd656ec12b091c17

# Unmont format is not necessary, but you can also download it
# checked_download amt-prove-coset0-5DWgDV-10-20.bin a132ba9fa48c338c478a3e9d7d1cde13d77c6096d3cca1ac28f091315ca58428  
# checked_download amt-prove-coset1-5DWgDV-10-20.bin 58ee8752e93408b79f3640d7712f5915213e69b872a3393ac67824d29d95379c  
# checked_download amt-prove-coset2-5DWgDV-10-20.bin 0f12211c21816a55ef856fc4f22532e4a5f286bb68d7dfec0f8102a224613533  
