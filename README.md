# Additional brew tools tap

## Why?

Homebrew tap for my personal CLI tools, contains useful utilities I use from time to time and made available for anyone to install.

## Available Formulae

| Formula | Description |
|---------|-------------|
| [gen-secp](Formula/gen-secp.rb) | Generate secp256k1 keypairs for local development |
| [mkpasswd](Formula/mkpasswd.rb) | Generate hashed passwords (from whois package) |
| [pa](Formula/pa.rb) | A simple CLI password manager using age encryption |

## How do I install these formulae?

```console
brew tap tonidy/tools-tap
brew install mkpasswd
brew install pa
brew install gen-secp
```

### or

```console
brew install tonidy/tools-tap/mkpasswd
brew install tonidy/tools-tap/pa
brew install tonidy/tools-tap/gen-secp
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
