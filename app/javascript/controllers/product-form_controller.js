import { Controller } from "stimulus"

export default class extends Controller {
  initialize() {
    console.log('Hello from stimulus!');
  }

  static get targets() {
    return ['quantity'];
  }

  countCharacters(event) {
    console.log(event);
  }

  increment() {
    console.log(this.quantityTarget.max)
    let incvalue = Number(this.quantityTarget.value);
    this.quantityTarget.setCustomValidity("")
    if(incvalue > this.quantityTarget.max) {
      this.quantityTarget.setCustomValidity("Stock not available")
    } else {
      if( !isNaN( incvalue ))
        this.quantityTarget.value = incvalue+1;
      return false
    }
  }

  decrement() {
    let decvalue = Number(this.quantityTarget.value);
    if( !isNaN( decvalue ) && decvalue > 0) 
      this.quantityTarget.value = decvalue-1;
    return false
  }
}