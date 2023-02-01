<br/>
<p align="center">
  <a href="https://github.com/florisvanenter/powershell">
    <img src="https://github.com/florisvanenter/powershell/blob/main/logo.png?raw=true" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Powershell scripts</h3>

  <p align="center">
    Create a low-key life with scripts. Why do things yourself?
    <br/>
    <br/>
    <a href="https://github.com/florisvanenter/powershell"><strong>Explore the docs »</strong></a>
    <br/>
    <br/>
    <a href="https://github.com/florisvanenter/powershell">View Demo</a>
    .
    <a href="https://github.com/florisvanenter/powershell/issues">Report Bug</a>
    .
    <a href="https://github.com/florisvanenter/powershell/issues">Request Feature</a>
  </p>
</p>

![Downloads](https://img.shields.io/github/downloads/florisvanenter/powershell/total) ![Contributors](https://img.shields.io/github/contributors/florisvanenter/powershell?color=dark-green) ![Issues](https://img.shields.io/github/issues/florisvanenter/powershell) ![License](https://img.shields.io/github/license/florisvanenter/powershell)

## Table Of Contents

- [Table Of Contents](#table-of-contents)
- [About The Project](#about-the-project)
- [Built With/for](#built-withfor)
- [Usage](#usage)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
  - [Creating A Pull Request](#creating-a-pull-request)
- [License](#license)
- [Authors](#authors)

## About The Project

After searching for a lot of scripts in my lifetime I started to gather them in a repository. Of course I was not as tidy as the scripts in this repository, but I tried to be as thorough as I could be.

These are the subjects of my scripts;

| Name | Description |
| ---- | ----------- |
| Active Directory | The local AD |
| Computer | Specific computer(s) or server(s) |
| Endpoint - Intune | Scripts to be used with Intune |
| Microsoft Graph | Talk to the Microsoft cloud via the API |

Of course nobody is perfect. I have a specific style which could not match yours. If you have any hints to improve, feel free to let me know; [floris@entermi](mailto:floris@entermi.nl)

## Built With/for

I tried to keep everything compatible with Powershell 7 and Powershell 5.x.

## Usage

These scripts are built to run from the shell using parameters. Examples are;

PS > .\Set-DNSServersOnServers.ps1 -OldDns 10.0.0.10 -NewDns '10.0.0.100','10.0.0.200' -Computername 'NLSERVER'
PS > .\Set-DNSServersOnServers.ps1 -Secret 'I_261~ISZAkiEW6yupjiNGk-ZdZrY1f7zwFpzbx3' -Id 'dd372274-a277-11ed-a8fc-0242ac120002' -Version 'beta'

## Roadmap

See the [open issues](https://github.com/florisvanenter/powershell/issues) for a list of proposed features (and known issues).

It is a work-in-progress repository. So scripts will be added when found/needed.

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.
* If you have suggestions for adding or removing projects, feel free to [open an issue](https://github.com/florisvanenter/powershell/issues/new) to discuss it, or directly create a pull request after you edit the *README.md* file with necessary changes.
* Please make sure you check your spelling and grammar.
* Create individual PR for each suggestion.
* Please also read through the [Code Of Conduct](https://github.com/florisvanenter/powershell/blob/main/CODE_OF_CONDUCT.md) before posting your first idea as well.

### Creating A Pull Request

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See [LICENSE](https://github.com/florisvanenter/powershell/blob/main/LICENSE.md) for more information.

## Authors

* **Floris van Enter** - [Github](https://github.com/florisvanenter/)
