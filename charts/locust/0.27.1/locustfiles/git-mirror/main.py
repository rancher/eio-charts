from locust import task, TaskSet
from locust_plugin_git import GitUser

class RancherCatalogUser(GitUser):
    repository = "https://cowboy.domains.rancher.io/rancher-catalog"

    @task
    class RancherCatalogTasks(TaskSet):
        @task
        def clone(self):
            self.client.clone()

        @task
        def ls_remote(self):
            self.client.ls_remote()

