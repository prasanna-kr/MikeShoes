console.log('Hello from My JS')


let value = Number(document.getElementById("sst").value)
console.log(value)
debugger;
$('#incrementBtn').click(function() {
    $('#sst').val(value+1)
})
$('#decrementBtn').click(function() {
    $('#sst').val(value-1)
})
