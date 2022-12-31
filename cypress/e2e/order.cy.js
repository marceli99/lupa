describe("E2E - Order item", () => {
    it("Wpisywanie wartości w pole", () => {
        // cy.request('POST', 'http://localhost:8888/users/827')
        cy.visit("http://localhost:3000");
        cy.get('#product_order_8').click();
        cy.wait(100);
        cy.get('#product_order_2').click();
        cy.wait(100);
        cy.get('.btn').contains("Checkout").click();
        cy.get('#checkout_name').type('James');
        cy.get('#checkout_phone').type('111111111');
        cy.get('#checkout_email').type('test@test.pl');
        cy.get('[type="radio"]').check('self_pickup');
        cy.get('.btn').contains("Order").click();
    })
})
