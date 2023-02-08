export function transform(PD) {
    let normalized_event = {}
    let parsed = JSON.parse(Object.keys(PD.inputRequest.body)[0])

    if (parsed.event === "Monitor") {
        parsed.dedup_key = `Twingate Connector ${parsed.connector}`
        if (parsed.type === "trigger") {
            normalized_event = {
                event_action: PD.Trigger,
                dedup_key: parsed.dedup_key,
                payload: {
                    summary: `${parsed.dedup_key} - ${parsed.log}`,
                    severity: "critical",
                    source: `Twingate Connector`,
                    custom_details: JSON.stringify(parsed, null, 4)
                }
            }
        } else {
            normalized_event = {
                event_action: PD.Resolve,
                dedup_key: `Twingate Connector ${parsed.connector}`
            }
        }
    } else {
        parsed.dedup_key = `${parsed.connection.error_message}-${parsed.connector.name}-${parsed.connection.client_ip}-${parsed.user.id}-${parsed.resource.address}`
        normalized_event = {
            dedup_key: parsed.dedup_key,
            event_action: PD.Trigger,
            payload: {
                summary: `Twingate: ${parsed.resource.address} - ${parsed.connection.error_message}`,
                severity: "info",
                source: `Twingate Connector ${parsed.connector.name}`,
                custom_details: JSON.stringify(parsed, null, 4)
            }
        };
    }



    PD.emitEventsV2([normalized_event]);
}