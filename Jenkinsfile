pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Margulan'
        STUDENT_SURNAME = 'Beket'
        STUDENT_GROUP   = 'it2-2302'
        STUDENT_ID      = '38109'
        IMAGE_NAME      = 'beket-margulan-devops'
        CONTAINER_NAME  = 'beket-margulan-container'
        APP_PORT        = '5050'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh '''
                    echo "Student: ${STUDENT_NAME} ${STUDENT_SURNAME}"
                    echo "Group: ${STUDENT_GROUP}"
                    echo "Student ID: ${STUDENT_ID}"
                    echo "Git commit: $(git rev-parse --short HEAD) - $(git log -1 --pretty=%s)"
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    chmod +x scripts/*.sh
                    ./scripts/Beket_Margulan_system.sh
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    for f in Dockerfile docker-compose.yml Beket_Margulan_info.txt config/app.conf app/app.py; do
                        test -f "$f" || { echo "MISSING: $f"; exit 1; }
                        echo "OK: $f exists"
                    done
                    bash -n scripts/Beket_Margulan_system.sh && echo "OK: bash script syntax"
                    grep -q "Student ID: ${STUDENT_ID}" Beket_Margulan_info.txt && echo "OK: student info is correct"
                    if command -v python3 >/dev/null 2>&1; then
                        python3 -m py_compile app/app.py && echo "OK: python syntax"
                    fi
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .
                    docker images ${IMAGE_NAME}
                '''
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p ${APP_PORT}:5050 \
                        -e STUDENT_NAME="${STUDENT_NAME}" \
                        -e STUDENT_SURNAME="${STUDENT_SURNAME}" \
                        -e STUDENT_GROUP="${STUDENT_GROUP}" \
                        -e STUDENT_ID="${STUDENT_ID}" \
                        ${IMAGE_NAME}:latest
                    sleep 3
                    docker ps --filter name=${CONTAINER_NAME}
                    docker logs ${CONTAINER_NAME}
                    docker exec ${CONTAINER_NAME} python -c "import urllib.request; print('Health:', urllib.request.urlopen('http://localhost:5050/health').read().decode())"
                '''
            }
        }
    }

    post {
        success { echo "Pipeline for ${STUDENT_NAME} ${STUDENT_SURNAME} finished successfully" }
        failure { echo "Pipeline failed - check the stage marked in red" }
    }
}
