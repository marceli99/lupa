import {Controller} from "@hotwired/stimulus"
import dragula from '../dragula';
import '../channels/index';

export default class extends Controller {
    static targets = ["modal"];

    connect() {
        this.modalElement = null;
        this.modalSource = null;
        this.modalTargetElement = null;

        const audio = new Audio('/notification.mp3');

        window.App.cable.subscriptions.create({channel: 'OrdersChannel'}, {
            connected() {
            },
            disconnected() {
            },
            received(data) {
                $.get(`board_order/${data['id']}`, (data) => {
                    $("#dropzone_waiting_for_approval").append(data);
                });

                let resp = audio.play();
                if (resp !== undefined) {
                    resp.then(_ => {
                    }).catch(error => {
                        console.log(error);
                    });
                }
            }
        });

        $('#delivery_times').select2({
            minimumResultsForSearch: -1,
        });

        let containers = $('.orders');
        let drake = dragula(containers.toArray(), {
            accepts: function (el, target, source, sibling) {
                if (target.getAttribute('data-status') === 'waiting_for_approval') {
                    return false;
                }

                return true;
            },
            revertOnSpill: true
        });

        drake.on('drop', (element, target, source, _sibling) => {
            this.modalElement = $(element);
            this.modalTargetElement = $(target);
            this.modalSource = $(source);

            this.openModal(source.getAttribute('data-status') === 'waiting_for_approval');
        });
    }

    openModal(firstDrag = false) {
        if (firstDrag) {
            $('#delivery_time_input').removeClass('hidden');
        }

        this.modalTarget.classList.remove('hidden');
    }

    confirmModal(e) {
        let deliveryTime = null;

        if (!$('#delivery_time_input').hasClass('hidden')) {
            deliveryTime = $('#delivery_times').val();
        }

        const csrfToken = document.getElementsByName("csrf-token")[0].content;
        $.ajax({
            type: 'PATCH',
            url: `/orders/${this.modalElement.find('h3').attr('id')}`,
            headers: {"X-CSRF-Token": csrfToken},
            data: {
                status: this.modalTargetElement.data('status'),
                estimated_delivery_date: deliveryTime,
            },
        });

        this.clearModalStyles();
    }

    cancelModal(e) {
        this.clearModalStyles();

        this.modalTargetElement.remove(this.modalElement[0]);
        this.modalSource.append(this.modalElement[0]);
    }

    clearModalStyles() {
        this.modalTarget.classList.add('hidden');
        $('#delivery_time_input').removeClass('hidden');
        $('#delivery_time_input').addClass('hidden');
        $('#delivery_times').val('0.5').trigger('change');
    }

    disconnect() {

    }
}
