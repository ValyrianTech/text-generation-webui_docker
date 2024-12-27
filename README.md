# Text Generation WebUI v2.0 for RunPod

A ready-to-use text generation interface powered by the popular text-generation-webui, optimized for RunPod deployment.

You can deploy this template on RunPod using the following link and picking one of the NVIDIA GPU instances:
[Deploy on RunPod](https://runpod.io/console/deploy?template=bzhe0deyqj&ref=2vdt3dn9)

## ✨ Features

- 💬 Text-generation-webui v2.0
- 🔗 OpenAI-compatible API
- 📦 Persistent storage for your models and chat history
- 🔒 Optional secure SSH access
- ⚡ Optimized for cloud GPU deployment

## 🚀 Getting Started

1. Deploy the template on RunPod
2. Access the web interface through the exposed port 7860
3. Start chatting with your AI assistant!

## 💾 Persistence

Your models, configurations, and chat history are automatically saved in the Network Volume if you use one. They will persist across pod restarts and updates.

if you need to install additional packages, you can start a web terminal and connect to the pod's container, or SSH into it.
You will need to activate the conda environment first:

```
conda activate /workspace/text-generation-webui/installer_files/env
```


## 🔗 API Access

The service includes an OpenAI-compatible API endpoint, allowing you to integrate it with other applications that support OpenAI's API format.

[text-generation-webui API documentation](https://github.com/oobabooga/text-generation-webui/blob/main/docs/12%20-%20OpenAI%20API.md)


## ⚙️ Template environment variables: automatic model download and UI parameters

This template supports two environment variables which you can specify via the **Edit Template button**.

* `MODEL`
  * Pass in the ID of a Hugging Face repo, or an `https://` link to a single GGML model file
  * Examples of valid values for `MODEL`:
    * `TheBloke/vicuna-13b-v1.3-GPTQ`
    * `https://huggingface.co/TheBloke/vicuna-13b-v1.3-GGML/resolve/main/vicuna-13b-v1.3.ggmlv3.q4_K_M.bin`
  * When a `MODEL` value is passed, the following will happen:
    * On Docker launch, the passed model will be automatically downloaded to `/workspace/text-generation-webui/models`
    * **Note: this may take some time and the UI will not be available until the model has finished downloading.**
    * Once the model is downloaded, text-generation-webui will load this model automatically
    * To monitor the progress of the download, you can SSH in and run:
      * `tail -100f /workspace/logs/fetch-model.log`
* `UI_ARGS`
  * Pass in any text-generation-webui launch parameters you want to use
  * For a guide to valid parameters, please see: https://github.com/oobabooga/text-generation-webui/tree/main#basic-settings
  * Example value: `--n-gpu-layers 100 --threads 1` to ensure a GGML model is fully loaded onto GPU, with optimal performance parameters.
  * Note: no checking for valid parameters is currently done. So if invalid params are entered, it can block text-generation-webui from launching.
   * If the UI does not launch, SSH in and run:
      * `tail -100f /workspace/logs/text-generation-webui.log` to see what the UI is doing.

## Server logs

The logs from launching text-generation-webui are stored at `/workspace/log/text-generation-webui.log`

You can read them by SSHing in and typing:
```
cat /workspace/text-generation-webui.log
```

Or to watch them live:
```
tail -100f /workspace/text-generation-webui.log
```

