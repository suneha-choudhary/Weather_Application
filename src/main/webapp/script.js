const container = document.querySelector('.container');
const search = document.querySelector('.search-box button');
const searchCoordinates = document.getElementById('search-coord');
const weatherBox = document.querySelector('.weather-box');
const weatherDetails = document.querySelector('.weather-details');
const error404 = document.querySelector('.not-found'); 
const cityHide = document.querySelector('.city-hide');
const city = document.querySelector('.search-box input').value;
const apiKey = 'abeabd49919f4aafe92338a31ded7745'; 
const pinbutton = document.getElementById('.pinbtn');

let pinnedcities = JSON.parse(localStorage.getItem('pinnedcities')) || [];

	search.addEventListener('click', () => {
	
		const city = document.querySelector('.search-box input').value;
		
		if(city == '') return;
		fetchWeatherByCity(city);
		});
	console.log(1);
	searchCoordinates.addEventListener('click', () => {
	console.log(2);
		const latitude = document.getElementById('latitude').value;
		const longitude = document.getElementById('longitude').value;
		if(latitude == '' || longitude =='') return;
		fetchWeatherByCoords(latitude,longitude);
		});
	console.log(3);
		
		function updatePinnedCities(){
			localStorage.setItem('pinnedCities',JSON.stringify(pinnedcities));
			pinnedcities.forEach((cityData, index) => {
				const card = document.querySelector(`.card${index + 1}`);
				const temp = document.querySelector(`.pintemp${index + 1}`);
				const desc = document.querySelector(`.description${index + 1}`);
				card.innerHTML = cityData.city;
				temp.innerHTML = `${cityData.temp}<span>°C</span>`;
				desc.innerText = cityData.desc;
			});
		}
		/*
		function removeCity(id) {
			const index = parseInt(id.replace('pincity', '')) -1;
			pinnedcities.splice(index, 1);
			pinnedcities.push({ city: '',temp: '0', desc: 'Broken Clouds'});
			updatePinnedCities();
		}
			*/
			function removeCity(cardId) {
			    document.getElementById(cardId).innerHTML = '';
			    if (cardId === 'pincity1') {
			        document.querySelector('.pintemp1').innerHTML = '0<span>°C</span>';
			        document.querySelector('.description1').innerHTML = 'Broken Clouds';
			    } else if (cardId === 'pincity2') {
			        document.querySelector('.pintemp2').innerHTML = '0<span>°C</span>';
			        document.querySelector('.description2').innerHTML = 'Broken Clouds';
			    } else if (cardId === 'pincity3') {
			        document.querySelector('.pintemp3').innerHTML = '0<span>°C</span>';
			        document.querySelector('.description3').innerHTML = 'Broken Clouds';
			    }

			    savePinnedCitiesToDB();
			}

			document.addEventListener('DOMContentLoaded', () => {
			    loadPinnedCitiesFromDB();
			});

			function loadPinnedCitiesFromDB() {
			    const username = 'user123'; // Replace with the actual username
			    fetch('http://localhost:8080/weatherApp/getPinnedCities', {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/json'
			        },
			        body: JSON.stringify({
			            username: username
			        })
			    }).then(response => response.json())
			      .then(data => {
			          const pinnedCities = data;
			          if (pinnedCities.length > 0) {
			              const firstCity = pinnedCities[0];
			              document.getElementById('pincity1').innerText = firstCity.city;
			              document.querySelector('.pintemp1').innerText = `${firstCity.temp}°C`;
			              document.querySelector('.description1').innerText = firstCity.desc;
			          }
			          if (pinnedCities.length > 1) {
			              const secondCity = pinnedCities[1];
			              document.getElementById('pincity2').innerText = secondCity.city;
						  document.querySelector('.pintemp2').innerText = `${secondCity.temp}°C`;
						                document.querySelector('.description2').innerText = secondCity.desc;
						            }
						            if (pinnedCities.length > 2) {
						                const thirdCity = pinnedCities[2];
						                document.getElementById('pincity3').innerText = thirdCity.city;
						                document.querySelector('.pintemp3').innerText = `${thirdCity.temp}°C`;
						                document.querySelector('.description3').innerText = thirdCity.desc;
						            }
						        })
						        .catch(err => console.error('Error:', err));
						  }
			
	document.getElementById('customDateInput').addEventListener('submit', (event) => {
	    event.preventDefault();
	    const startDate = document.querySelector('.startDate').value; // Change to .startDate
	    const endDate = document.querySelector('.endDate').value; // Change to .endDate
	    const city = document.getElementById('avgCity').value; // Keep id reference for city selection
	    fetchAndCalculateAverage(startDate, endDate, city);
	});

			function pinCity(city, temp, description) {
			    if (!city || !temp || !description) {
			        console.error('Invalid data provided for pinning the city');
			        return;
			    }

			    const cards = [
			        { cityElem: 'pincity1', tempElem: 'pintemp1', descElem: 'description1' },
			        { cityElem: 'pincity2', tempElem: 'pintemp2', descElem: 'description2' },
			        { cityElem: 'pincity3', tempElem: 'pintemp3', descElem: 'description3' }
			    ];

			    for (let i = 0; i < cards.length; i++) {
			        const card = cards[i];
			        const cityElem = document.getElementById(card.cityElem);
			        if (cityElem && cityElem.innerHTML === '') {
			            cityElem.innerHTML = city;
			            document.querySelector(`.${card.tempElem}`).innerHTML = `${temp}<span>°C</span>`;
			            document.querySelector(`.${card.descElem}`).innerHTML = description;
			            savePinnedCitiesToDB();
			            return;
			        }
			    }

			    console.warn('All pinned city slots are filled. Consider removing one before adding a new one.');
			}
	
	function fetchWeatherByCity(city){
		const apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q='+city+'&units=metric&appid='+ apiKey;
		fetchWeather(apiUrl);
	}
	function fetchWeatherByCoords(latitude,longitude){
		const apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat='+latitude+'&lon='+longitude+'&units=metric&appid='+apiKey;
		fetchWeather(apiUrl);
	}
	
	function fetchWeather(apiUrl){
	fetch(apiUrl).then(response => response.json()).then(json => {
		console.log(json);
		if(json.cod == '404'){
			cityHide.textContent = city;
			
			container.style.height = '25rem';
			weatherBox.classList.remove('active');
			weatherDetails.classList.remove('active');
			error404.classList.add('active');
			return;
		}
	
		const image = document.querySelector('.weather-box img');
		const temperature = document.querySelector('.weather-box .temperature');
		const description = document.querySelector('.weather-box .description');
		const humidity = document.querySelector('.weather-details .humidity span');
		const wind = document.querySelector('.weather-details .wind span');

			cityHide.textContent = city;
		console.log("hi");
			container.style.height = '34.688rem';
			container.classList.add('active');
			weatherBox.classList.add('active');
			weatherDetails.classList.add('active');
			error404.classList.remove('active');
			
			setTimeout(() => {
				container.classList.remove('active');
			}, 2500);
		
			switch (json.weather[0].main) {
				case 'Clear':
					image.src = 'images/clear.png';
					document.body.style.backgroundImage = 'url("images/clear-sky.jpg")';
					break;
	
				case 'Rain':
					image.src = 'images/rain.png';
					document.body.style.backgroundImage = 'url("images/rainy.jpg")';
					break;
	
				case 'Snow':
					image.src = 'images/snow.png';
					document.body.style.backgroundImage = 'url("images/snowy.jpg")';
					break;
	
				case 'Clouds':
					image.src = 'images/cloud.png';
					document.body.style.backgroundImage = 'url("images/cloud.jpg")';
					break;
					
				case 'Mist':
					image.src = 'images/mist.png';
					document.body.style.backgroundImage = 'url("images/foggy.webp")';
					break;
					
				case 'Haze':
					image.src = 'images/haze.png';
					document.body.style.backgroundImage = 'url("images/haze.jpg")';
					break;
					
				default:
					image.src = 'images/cloud.png';
					
			}
			
			temperature.innerHTML = `${parseInt(json.main.temp)}<span>°C</span>`;
            description.innerHTML = `${json.weather[0].description}`;
            humidity.innerHTML = `${json.main.humidity}%`;
            wind.innerHTML = `${parseInt(json.wind.speed)} Km/h`;
			
			document.getElementById("pinbutton").onclick = () => pinCity(document.getElementById("cityInput").value, parseInt(json.main.temp), description.innerHTML);
			
			const infoWeather = document.querySelector('.info-weather');
			const infoHumidity = document.querySelector('.info-humidity');
			const infoWind = document.querySelector('.info-wind');
			
			const elCloneInfoWeather = infoWeather.cloneNode(true);
			const elCloneInfoHumidity = infoHumidity.cloneNode(true);
			const elCloneInfoWind = infoWind.cloneNode(true);
			
			elCloneInfoWeather.id = 'clone-info-weather';
			elCloneInfoWeather.classList.add('active-clone');
						
			elCloneInfoHumidity.id = 'clone-info-humidity';
			elCloneInfoHumidity.classList.add('active-clone');
			
			elCloneInfoWind.id = 'clone-info-wind';
			elCloneInfoWind.classList.add('active-clone');
			
			setTimeout(() => {
				infoWeather.insertAdjacentElement("afterend",elCloneInfoWeather);
				infoHumidity.insertAdjacentElement("afterend",elCloneInfoHumidity);
				infoWind.insertAdjacentElement("afterend",elCloneInfoWind);
			}, 2200);
				
				const cloneInfoWeather = document.querySelectorAll('.info-weather.active-clone');
				const totalCloneInfoWeather = cloneInfoWeather.length;
				const cloneinfoWeatherFirst = cloneInfoWeather[0];
				
				const cloneInfoHumidity = document.querySelectorAll('.info-humidity.active-clone');
				const cloneinfoHumidityFirst = cloneInfoHumidity[0];
				
				const cloneInfoWind = document.querySelectorAll('.info-wind.active-clone');
				const cloneinfoWindFirst = cloneInfoWind[0];
				
				if(totalCloneInfoWeather>0){
					cloneinfoWeatherFirst.classList.remove('active-clone');
					cloneinfoHumidityFirst.classList.remove('active-clone');
					cloneinfoWindFirst.classList.remove('active-clone');
				
					setTimeout(() => {
						cloneinfoWeatherFirst.remove();
						cloneinfoHumidityFirst.remove();
						cloneinfoWindFirst.remove();
					}, 2200);	
				}
							
		});

}
	updatePinnedCities();
	
	const apiBaseUrl = 'http://localhost:8080/project/';

	function savePinnedCitiesToDB() {
	    const username = 'suneha@gmail.com'; // Replace with the actual username
	    const pinnedCities = [
	        {
	            city: document.getElementById('pincity1').innerText,
	            temp: document.querySelector('.pintemp1').innerText.replace('°C', ''),
	            desc: document.querySelector('.description1').innerText
	        },
	        {
	            city: document.getElementById('pincity2').innerText,
	            temp: document.querySelector('.pintemp2').innerText.replace('°C', ''),
	            desc: document.querySelector('.description2').innerText
	        },
	        {
	            city: document.getElementById('pincity3').innerText,
	            temp: document.querySelector('.pintemp3').innerText.replace('°C', ''),
	            desc: document.querySelector('.description3').innerText
	        }
	    ].filter(cityData => cityData.city !== '');
		fetch('/savePinnedCities', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json'
		        },
		        body: JSON.stringify({
		            "username": username,
		            "pinnedCities": pinnedCities
		        })
		    }).then(response => response.text())
		      .then(data => console.log(data))
		      .catch(err => console.error('Error:', err));
	}
		
	function loadPinnedCitiesFromDB(){
		const username = 'suneha@gmail.com';
		fetch(`/getPinnedCities`,{
			method: 'POST',
			headers:{
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				"username": username
			})
		}).then(response => response.json())
			.then(data => {
				pinnedcities = data;
				updatePinnedCities();
			})
			.catch(err => console.error('Error: ', err));
	}

	function fetchAndCalculateAverage(startDate, endDate, avgCity) {
	        fetch('./data.json')
	            .then(res => res.json())
	            .then(data => {
	                console.log('Fetched data:', data);
	                const cities = data.cities;
	                const cityData = cities.find(city => city.city === avgCity);
	                if (cityData) {
	                    const temperatures = cityData.temperatures;
	                    let total = 0;
	                    let count = 0;

	                    for (const date in temperatures) {
	                        if (date >= startDate && date <= endDate) {
	                            total += temperatures[date];
	                            count++;
	                        }
	                    }

	                    if (count > 0) {
	                        const average = total / count;
	                        // Display average temperature on the web page
	                        const averageResult = document.getElementById('averageResult');
	                        averageResult.innerHTML = "<p>Average temperature in " + avgCity + " between " + startDate + " and " + endDate + " is " + average.toFixed(2) + " °C</p>";
	                    } else {
	                        console.log("No temperature data found between " + startDate + " and " + endDate);
	                        // Display message if no data found
	                        const averageResult = document.getElementById('averageResult');
	                        averageResult.innerHTML = "<p>No temperature data found between " + startDate + " and " + endDate + "</p>";
	                    }
	                } else {
	                    console.log("City '" + avgCity + "' not found in the data");
	                    // Display message if city not found
	                    const averageResult = document.getElementById('averageResult');
	                    averageResult.innerHTML = "<p>City '" + avgCity + "' not found in the data</p>";
	                }
	            })
	            .catch(err => console.error('Error fetching data:', err));
	    }
	

