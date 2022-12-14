import jquery from 'jquery'

window.$ = jquery;
window.jQuery = jquery;

import select2 from 'select2';

select2($);

import "@hotwired/turbo-rails"
import './controllers/index.js'


$(document).ready(() => {
    let main = $('main');
    let titles = $('#categories_list').children();
    let categories = $('#products .dish_category')

    let buttons = $("form[action='/cart/add'] .btn");
    buttons.on('click', () => {
        if (!$('#aside_open').is(':checked')) {
            $('#aside_open_label').click();
        }
    });


    const observer = new IntersectionObserver(entries => {
            entries.forEach((entry) => {
                let index = categories.index(entry.target);
                titles[index].classList.toggle('selected', entry.isIntersecting);
            });
        },
        {
            threshold: 0.01,
        });

    categories.each((_, category) => {
        observer.observe(category);
    })

    titles.each((_, item) => {
        $(item).on('click', () => {
            let scroll = main.scrollTop();
            let top = $(`#${item.innerText.replaceAll(/\s/g, '')}`).offset().top;

            main.animate({
                scrollTop: top + scroll - item.offsetHeight
            }, 500);
        });
    });
});

$(document).on('click', 'a[href^="#"]', function (event) {
    event.preventDefault();

    $('html, body').animate({
        scrollTop: $($.attr(this, 'href')).offset().top
    }, 500);
})
