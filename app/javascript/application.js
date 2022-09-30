import jquery from 'jquery'
import "@hotwired/turbo-rails"

window.$ = jquery;


$(document).ready(() => {
    let main = $('main');
    let titles = $('#categories_list').children();
    let categories = $('#products .dish_category')

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