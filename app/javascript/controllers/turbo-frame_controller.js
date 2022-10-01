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

            let timeIntervals = this.getTimeIntervals(moment().add(3, 'hours'));
            let select = $('#order_for_select')
            select.select2({
                data: timeIntervals.map((interval, index) => {
                    return {id: index, text: interval.format('LT')}
                }),
                minimumResultsForSearch: -1,
            });

            select.on('select2:select', e => this.saveInput(e));
            let hourData = localStorage.getItem('hour');
            if (hourData !== null && hourData < timeIntervals.length) {
                select.val(hourData).trigger('change');
            }
        }
    }

    toggleDelivery(e) {
        localStorage.setItem(e.target.name, e.target.value);
        let element = $('#delivery_details');

        element.removeClass('hidden');
        if (e.target.value !== 'delivery') {
            element.addClass('hidden');
        }
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