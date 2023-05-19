resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "conversationId" = {
                "type" = "string"
            },
            "participantId" = {
                "type" = "string"
            },
            "phone" = {
                "type" = "string"
            },
            "queueId" = {
                "type" = "string"
            },
            "scriptId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\n\"scriptId\": \"$!{input.scriptId}\",\n\"callbackNumbers\": [ \"$${input.phone}\" ],\n\"routingData\": {\n\"queueId\": \"$${input.queueId}\"\n}\n}"
        request_type         = "POST"
        request_url_template = "/api/v2/conversations/$${input.conversationId}/participants/$${input.participantId}/callbacks"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}