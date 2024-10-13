# Immich Better Face Detection

Immich Better Face Detection aims to improve the accuracy of face detection within the Immich app by using a method described by [mertalev](https://github.com/mertalev).

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project enhances face detection capabilities for the Immich application with model `buffalo_l` selected in Immich settings. It needs to be run on each system with an `immich_machine_learning` container (multiple containers are only appliciable if using remote machine learning).

It automates the steps provided by [mertalev](https://github.com/mertalev) in a [discord discussion](https://discord.com/channels/979116623879368755/1272383382487040020/1272397588154286233).

## Features

- Enhanced face detection algorithm
- Improved facial detection
- Easy integration with Immich

## Installation

Run the following command:

```
curl -o- https://raw.githubusercontent.com/1-tempest/immich-better-face-detection/main/detect-more-faces.sh | sudo bash
```

## Usage

Upon successful completion you will now be using a better facial detection model on all future facial detection jobs.
No further action is required.

## Apply to Entire Library (optional)

You can apply it to your existing library by visiting `Administration -> Jobs -> Face Detection` and pressing `All`.

Please note that **all recognized faces will be lost** performing this action.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
