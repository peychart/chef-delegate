# chef-delegate-cookbook

 Chef cookbook to install/config the prox "delegate".

## Supported Platforms

 Ubuntu/debian

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chef-delegate']['url']</tt></td>
    <td>String</td>
    <td>URL where to get the binary</td>
    <td><tt>'https://github.com/peychart/chef-delegate/raw/master'</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-delegate']['options']</tt></td>
    <td>String array</td>
    <td>list of options to the command line</td>
    <td><tt>['-P3129', 'SERVER="ftp"']</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-delegate']['paramsFilePath']</tt></td>
    <td>String</td>
    <td>localisation of the parameters files</td>
    <td><tt>'/usr/local/etc/delegate'</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-delegate'][name of the parameters file]['callOption']</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-delegate'][name of the parameters file]['rules']</tt></td>
    <td>String array</td>
    <td>rules definition</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

## Binary compilation

 Depends on 'openssl' and 'zlib1g'.

 Get the last version of 'delegate' (see: http://www.delegate.org/delegate/download/).

    tar xzf delegateX.X.X.tar.gz
    cd delegateX.X.X
    make
    Put the binary 'delegated' where you need it...

 Regarding this cookbook, binaries are in a directory whose name matches the corresponding distribution...

## Usage

 Configurations can be defined in data bags.

 eg:

 Data bag "clusters":

    {
      "id": "proxy.my.domain",
      "chef-delegate": {
        "options": [
          "-P3129",
          "SERVER=\"ftp\"",
          "RELAY=\"proxy:*:*:*\"",
          "SRCIF=\"*:8020-8120:ftp-data\"",
          "CACHE=no",
          "RELIABLE=\"192.168.0.0/16,10.0.0.0/8\""
        ],
        "permit": {
          "callOptions": "PERMIT=\"ftp:\"",
          "rules": [
            "# 192.168.0.0/24 network anywhere:",
            "*:192.168.0.0/24",
            "*:192.168.1.11/32",
            "",
            "# Access to ftp.org from 192.168.73.17:",
            "ftp.org:192.168.73.17",
            "",
            ...
          ]
        }
      },
    }

 Vagranfile example:

    chef.json = {
      "chef-nodeAttributes" => {
        "databag_name" => "clusters"
      }
    }
    
    chef.run_list = [
      "recipe[chef-nodeAttributes::default]",
      "recipe[chef-delegate::default]"
    ]

### chef-delegate::default

Include `chef-delegate` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[chef-delegate::default]"
  ]
}
```

## License and Authors

Author:: PE, pf. (<peychart@mail.pf>)
