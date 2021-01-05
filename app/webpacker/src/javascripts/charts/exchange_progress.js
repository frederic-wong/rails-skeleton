new Chart(document.getElementById("barChart"), {
    type: 'bar',
    data: {
      labels: ["Not Started", "Blocked", "Ready to Close", "In Progress", "Closed"],
      datasets: [
        {
          label: "Exchanges",
          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
          data: [2478,267,1734,784,433]
        }
      ]
    },
    options: {
      legend: { display: false },
      // title: {
      //   display: true,
      //   text: 'Predicted world population (millions) in 2050'
      // }
    }
});
