import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        let statusInfo = $('#status-info');
        if (statusInfo.length) {
            this.refreshTimer = setInterval(() => {
                this.checkOrderStatus();
            }, 3000)

            if (statusInfo.attr('data-payment') === 'true') {
                let url = `${window.location.origin}/payment/${this.data.get('id')}`;
                window.open(url, '_blank');
            }
        }
    }

    disconnect() {
        if(this.refreshTimer) {
            clearInterval(this.refreshTimer);
        }
    }

    checkOrderStatus() {
        fetch(`${window.location.origin}/order_status/${this.data.get('id')}`)
            .then(response => response.json())
            .then(data => {
                if (data['status'] !== this.data.get("status")) {
                    location.reload();
                }
            })
    }
}
