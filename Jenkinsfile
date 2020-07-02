pipeline {
    agent { label 'Agent'}
    
environment {
   BRANCH_LIB = "development"
 }
 
   // triggers{
        //cron('0 12,23 * * *')
    //}
    
    stages {
    
    stage('Copy Artifacts') {
        steps {
            script {
                    sh 'rm -rf Libraries'
                echo 'Copy X Library'
                    step ([$class: 'CopyArtifact',
                    projectName: "X/${BRANCH_LIB}",
                    filter: "Framework/*.zip",
                    target: 'Libraries/X',
                    selector: lastSuccessful()]);
                    sh 'unzip Libraries/X/Framework/X.zip -d Libraries'
            }
        }
    }
    
        stage('Start Mockup Server') {
            steps {
            dir('wiremock'){
               sh'''
                java -jar wiremock-standalone-2.25.1.jar -port 9090 --root-dir stubs &
                sleep 3
                curl -X GET "http://localhost:9090/__admin/mappings"
                '''
               
        }
            }
        }

        stage('Enable POD to Cucumberish ') {
            steps {
                echo 'Installing POD'
                sh '/usr/local/bin/pod install'
            }
        }


    stage('Executing escenarios'){
       steps {
        sh'''
        instruments -s devices
        export LANG=en_US.UTF-8
        export LANGUAGE=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
        instruments -s devices | grep "^iPhone.*Simulator)$"  | cut -f 1 -d "(" >> simulatorList.txt
        instruments -s devices | grep "^QA" | cut -f 1 -d "(" >> connectedDevicesList.txt
            rm -rf automationCucumberish/DID-SDK-Libraries/*
            cp -r Libraries/Devices/*.framework automationCucumberish/DID-SDK-Libraries/
            rm -rf build/reports/*.xml
            while read device; do
            file=`echo $device | tr -d ' '`
                set -o pipefail && xcodebuild -workspace automationCucumberish.xcworkspace -scheme automationCucumberish -destination "name=${device}" test | /usr/local/bin/xcpretty -r junit -o build/reports/${file}.xml
            done < connectedDevicesList.txt
        '''
      }
    }
    
    }
   post {
        always {
            junit 'build/reports/*.xml'
            sh '''
            rm simulatorList.txt
            rm connectedDevicesList.txt
            rm -rf Libraries
            '''
        }
    }
}
