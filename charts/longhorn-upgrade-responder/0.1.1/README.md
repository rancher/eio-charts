# Upgrade Responder Chart

## Usage
1. Clone this repo
   ```
   git clone https://github.com/longhorn/upgrade-responder.git && cd upgrade-responder
   ```
1. Create a `my_values.yaml` file to hold customized Helm chart values. 
   At the minimum `my_values.yaml` should contain:
    ```yaml
    # Specify the name of the application that is using this Upgrade Responder server
    # This will be used to create a database named <application-name>_upgrade_responder
    # in the InfluxDB to store all data for this Upgrade Responder
    # The name must be in snake case format
    applicationName: awesome_app
    
    secret:
      name: upgrade-responder-secrets
      # Set this to false if you don't want to manage these secrets with helm
      managed: true
      influxDBUrl: "http://url-to-influxdb"
      influxDBUser: "username"
      influxDBPassword: "password"
    
    # This configmap contains information about the latest release
    # of the application that is using this Upgrade Responder
    configMap:
      responseConfig: |-
        {
           "Versions": [{
              "Name": "v1.1.1",
              "ReleaseDate": "2020-05-18T12:30:00Z",
              "Tags": ["latest"]
           }]
        }
    ```
2. Running
    ```shell
    helm upgrade --install awesome-app-upgrade-responder ./chart -f /path/to/my_values.yaml
    ```
## Notes
1. If you use the same InfluxDB for multiple Upgrade Responder chart releases, you can manually create a secret with the name specified by `secret.name` and set `secret.managed` to `false` so Helm doesn't complain about duplicated secret name.