FROM mcr.microsoft.com/devcontainers/base:noble

ARG TARGETARCH

ARG TERRAFORM_VERSION=1.15.3 \
    TFLINT_VERSION=0.62.1 \
    TFSEC_VERSION=1.28.14 \
    TERRAFORM_DOCS_VERSION=0.24.0 \
    SENTINEL_VERSION=0.40.0 \
    PRE_COMMIT_VERSION=4.6.0 \
    GH_CLI_VERSION=2.92.0 \
    AWS_CLI_VERSION=2.34.54

COPY --chmod=755 usr /usr

RUN case $TARGETARCH in \
        amd64) ARCH="x86_64" ;; \
        arm64) ARCH="aarch64" ;; \
        *) echo "Unsupported architecture: $TARGETARCH" >&2; exit 1 ;; \
    esac \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        lsb-release \
        python3-pip \
        unzip \
        qrencode \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg \
    && chmod a+r /etc/apt/keyrings/microsoft.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /etc/apt/keyrings/hashicorp.gpg \
    && chmod a+r /etc/apt/keyrings/hashicorp.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        azure-cli \
        terraform=${TERRAFORM_VERSION}-* \
    && pip3 install --no-cache-dir --break-system-packages pre-commit==${PRE_COMMIT_VERSION} \
    && rm -rf /var/lib/apt/lists/* \
    # AWS CLI
    && curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}-${AWS_CLI_VERSION}.zip" -o /tmp/awscli.zip \
    && unzip /tmp/awscli.zip -d /tmp/awscli \
    && /tmp/awscli/aws/install \
    && rm -rf /tmp/awscli /tmp/awscli.zip \
    # TFLint
    && curl -fsSL "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_${TARGETARCH}.zip" -o /tmp/tflint.zip \
    && unzip /tmp/tflint.zip -d /usr/local/bin \
    && rm -f /tmp/tflint.zip \
    && chmod +x /usr/local/bin/tflint \
    # TFSEC
    && curl -fsSL "https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-${TARGETARCH}" -o /usr/local/bin/tfsec \
    && chmod +x /usr/local/bin/tfsec \
    # Terraform Docs
    && curl -fsSL "https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-${TARGETARCH}.tar.gz" -o /tmp/terraform-docs.tar.gz \
    && tar -xzf /tmp/terraform-docs.tar.gz -C /usr/local/bin terraform-docs \
    && rm -f /tmp/terraform-docs.tar.gz \
    && chmod +x /usr/local/bin/terraform-docs \
    # Sentinel
    && curl -fsSL "https://releases.hashicorp.com/sentinel/${SENTINEL_VERSION}/sentinel_${SENTINEL_VERSION}_linux_${TARGETARCH}.zip" -o /tmp/sentinel.zip \
    && unzip /tmp/sentinel.zip -d /usr/local/bin \
    && rm -f /tmp/sentinel.zip \
    && chmod +x /usr/local/bin/sentinel \
    # GitHub CLI
    && curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_${TARGETARCH}.tar.gz" -o /tmp/gh.tar.gz \
    && tar -xzf /tmp/gh.tar.gz -C /usr/local/bin --strip-components=2 "gh_${GH_CLI_VERSION}_linux_${TARGETARCH}/bin/gh" \
    && rm -f /tmp/gh.tar.gz \
    && chmod +x /usr/local/bin/gh \
    # OCI CLI - https://docs.oracle.com/en-us/iaas/Content/dev/terraform/configuring.htm#security-token-auth
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
    --accept-all-defaults \
    --install-dir /usr/local/lib/oracle-cli \
    --exec-dir /usr/local/bin
