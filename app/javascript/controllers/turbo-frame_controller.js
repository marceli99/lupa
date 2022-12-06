import {Controller} from "@hotwired/stimulus";
import moment from 'moment';

export default class extends Controller {
    static targets = ['frame']

    frameTargetConnected(element) {
        let checkoutForm = $('#checkout_form');
        if (checkoutForm.length) {
            let deliveryMethod = localStorage.getItem('delivery_method');
            $('#checkout_name').val(localStorage.getItem('customer_name'));
            $('#checkout_phone').val(localStorage.getItem('customer_phone'));
            $('#checkout_email').val(localStorage.getItem('customer_email'));

            $('#delivery_street').val(localStorage.getItem('delivery_street'));
            $('#delivery_house').val(localStorage.getItem('delivery_house_number'));
            $('#delivery_city').val(localStorage.getItem('delivery_city'));

            $('#delivery').attr('checked', deliveryMethod === 'delivery')
            $('#self_pickup').attr('checked', deliveryMethod === 'self_pickup')

            if (deliveryMethod === 'delivery') {
                $('#delivery_details').toggleClass('hidden');
            }

            $('#order_for_select').select2({
                minimumResultsForSearch: -1,
            });
        }
    }

    toggleDelivery(e) {
        localStorage.setItem(e.target.name, e.target.value);
        let deliveryDetails = $('#delivery_details');

        deliveryDetails.removeClass('hidden');

        if (e.target.value !== 'delivery') {
            deliveryDetails.addClass('hidden');
        }

        $("#delivery_street").prop('required', e.target.value === 'delivery')
        $("#delivery_city").prop('required', e.target.value === 'delivery')
        $("#delivery_house").prop('required', e.target.value === 'delivery')
    }

    saveInput(e) {
        localStorage.setItem(e.target.name, e.target.value);
    }

    getTimeIntervals(endTime) {
        let timeIntervals = [];
        let startTime = moment().add(15 - moment().minute() % 15, 'minutes');

        while (startTime <= endTime) {
            timeIntervals.push(new moment(startTime));
            startTime.add(15, 'minutes');
        }

        return timeIntervals;
    }
}