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

## Usage

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
