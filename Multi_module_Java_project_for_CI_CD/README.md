### Multi-module Java template project using Maven ###

This is basic skeleton of multimodule Java project using Maven artefact. The aggregator is located in the project's root directory and must have packaging of type pom. All the required dependencies and plugins along with its version can be found in dependencyManagement and pluginManagement section of root pom.xml

This project will be further used for explaining CI/CD pipeline using Azure DevOps.
The *aria* parent pom.xml has modules
- bot
- util

The basic Java project can be created using
```
mvn archetype:generate -DgroupId=com.hmi.aria -DartifactId=aria -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
````