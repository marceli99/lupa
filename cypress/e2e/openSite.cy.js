/// <reference types="cypress" />

describe("E2E", () => {
    it("Visit main page", () => {
        cy.visit("http://localhost:3000");
    })
})
