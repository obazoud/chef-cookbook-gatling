gatling Cookbook
=======================
This cookbook install the [Gatling Stress Tool](http://gatling-tool.org/) for performance testing.

Requirements
------------
This cookbook was written on Amazon Linux so YMMV with other operating systems. Feel free to submit me a pull request. :)

This cookbook depends on the folling cookbooks:
- `java` - Java is required to run Gatling.
- `ark` - This is used to install the Gatling tar ball
- `ulimit` - Tweak some limits for Gatling
- `sysctl` - Tweak some kernel params for Gatling

Attributes
----------

#### gatling::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gatling']['user']</tt></td>
    <td>String</td>
    <td>Gatling user</td>
    <td><tt>gatling</tt></td>
  </tr>
  <tr>
    <td><tt>['gatling']['group']</tt></td>
    <td>String</td>
    <td>Gatling group</td>
    <td><tt>gatling</tt></td>
  </tr>
  <tr>
    <td><tt>['gatling']['install_prefix']</tt></td>
    <td>String</td>
    <td>Gatling install prefix. A Gatling versioned subdir will be created, along with a symling that is added to the path</td>
    <td><tt>/usr/local</tt></td>
  </tr>
  <tr>
    <td><tt>['gatling']['download_url']</tt></td>
    <td>String</td>
    <td>Gatling tarball package download URL. Set this attribute yourself by getting a URL here: http://gatling-tool.org/</td>
    <td><tt>NONE</tt></td>
  </tr>  <tr>
    <td><tt>['gatling']['version']</tt></td>
    <td>String</td>
    <td>Gatling version</td>
    <td><tt>2.0.0-M3a</tt></td>
  </tr>
</table>

Usage
-----
#### gatling::default

Set the `download_url` attribute.

Just include `gatling` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gatling]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Joe Richards <nospam-github@disconformity.net>
