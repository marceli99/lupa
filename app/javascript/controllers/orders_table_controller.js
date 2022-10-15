import {Controller} from "@hotwired/stimulus"
import dragula from '../dragula';
import '../channels/index';

export default class extends Controller {
    connect() {
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

        let containers = $('.orders');
        let drake = dragula(containers.toArray());

        drake.on('drop', (element, target, _source, _sibling) => {
            let item = $(element);
            const csrfToken = document.getElementsByName("csrf-token")[0].content;
            $.ajax({
                type: 'PATCH',
                url: `/orders/${item.find('h3').attr('id')}`,
                headers: {"X-CSRF-Token": csrfToken},
                data: {status: $(target).data('status')},
            });
        });
    }

    disconnect() {

    }
}
