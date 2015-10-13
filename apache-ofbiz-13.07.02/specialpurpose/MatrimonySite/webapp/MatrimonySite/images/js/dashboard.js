$(document).ready(function() {
	CustomerChartLayer.init();
	CustomerGridLayer.init();
});
if (typeof (CustomerChartLayer) == "undefined") {
	var CustomerChartLayer = (function() {
		var chart;
		var initJqxElements = function() {
			$("#rangeTime").jqxDateTimeInput({ width: 250, height: 25,  selectionMode: 'range' });
			var end = new Date();
			var start = new Date();
		    var start = new Date(start.setDate(start.getDate() - 7));
			$("#rangeTime").jqxDateTimeInput('setRange', start, end);
			$("#rangeTime").trigger('change');
		};
		var renderChart = function() {
			 var settings = {
		                title: multiLang.MSRegisteredUsers,
		                description: multiLang.MSStatisticsTheNumberOfPeopleRegisteredInTheWeek,
		                enableAnimations: true,
		                showLegend: true,
		                padding: { left: 10, top: 10, right: 15, bottom: 10 },
		                titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },
		                source: _data(),
		                colorScheme: 'scheme05',
		                xAxis: {
		                    dataField: 'Day',
		                    unitInterval: 1,
		                    tickMarks: { visible: true, interval: 1 },
		                    gridLinesInterval: { visible: true, interval: 1 },
		                    valuesOnTicks: false,
		                    padding: { bottom: 10 }
		                },
		                valueAxis: {
		                    unitInterval: 10,
		                    minValue: 0,
		                    maxValue: 50,
		                    title: { text: multiLang.MSQuantity },
		                    labels: { horizontalAlignment: 'right' }
		                },
		                seriesGroups:
		                    [
		                        {
		                            type: 'line',
		                            series:
		                            [
										{
										    dataField: 'Total',
										    symbolType: 'square',
										    labels:
										    {
										        visible: true,
										        backgroundColor: '#FEFEFE',
										        backgroundOpacity: 0.2,
										        borderColor: '#7FC4EF',
										        borderOpacity: 0.7,
										        padding: { left: 5, right: 5, top: 0, bottom: 0 }
										    }
										},
		                                {
		                                    dataField: 'RequestFriend',
		                                    symbolType: 'square',
		                                    labels: 
		                                    {
		                                        visible: true,
		                                        backgroundColor: '#FEFEFE',
		                                        backgroundOpacity: 0.2,
		                                        borderColor: '#7FC4EF',
		                                        borderOpacity: 0.7,
		                                        padding: { left: 5, right: 5, top: 0, bottom: 0 }
		                                    }
		                                }
		                            ]
		                        }
		                    ]
		            };
		            $('#chartContainer').jqxChart(settings);
		};
		var handlerEvents= function() {
			$('#rangeTime').on('change', function (event){
				renderChart();
			});
		};
		var _data = function() {
			var range = $("#rangeTime").jqxDateTimeInput('getRange');
			return DataAccess.getData({
				url: "loadCustomersDataChart",
				data: {from: range.from.getTime(), to: range.to.getTime()},
				source: "listCustomers"});
		};
		return {
			init: function() {
				handlerEvents();
				initJqxElements();
			},
			_data: _data
		};
	})();
}
if (typeof (CustomerGridLayer) == "undefined") {
	var CustomerGridLayer = (function() {
		var _data = function() {
			return DataAccess.getData({
			url: "loadCustomers",
			data: {},
			source: "listCustomers"});
		}
		var initJqxElements = function() {
			var source =
            {
                localdata: _data(),
                datafields:
                [
                    { name: 'partyId', type: 'string' },
                    { name: 'partyFullName', type: 'string' },
                    { name: 'casteName', type: 'string' },
                    { name: 'city', type: 'string' },
                    { name: 'genderDetails', type: 'string' },
                    { name: 'maritalStatus', type: 'string' },
                    { name: 'birthDate', type: 'date'}
                ],
                datatype: "json"
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#gridCustomer").jqxGrid({
            	localization: getLocalization(),
		        width: '100%',
		        theme: "energyblue",
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                columns: [
                  { text: multiLang.MSPartyId, datafield: 'partyId', columntype: 'textbox', filtertype: 'input', width: 130,
                	  cellsrenderer: function(row, colum, value){
                		  return "<div style='margin: 4px;'><a href='Profile?partyId=" + value + "'>" + value + "</a></div>";
                	  }  
                  },
                  { text: multiLang.MSFirstName, datafield: 'partyFullName', columntype: 'textbox', filtertype: 'input', width: 200 },
                  { text: multiLang.MSCaste, datafield: 'casteName', columntype: 'textbox', filtertype: 'input', width: 150 },
                  { text: multiLang.MSCity, datafield: 'city', columntype: 'textbox', filtertype: 'checkedlist', width: 100 },
                  { text: multiLang.MSGender, datafield: 'genderDetails', columntype: 'textbox', filtertype: 'checkedlist', width: 100 },
                  { text: multiLang.MSMaritalStatus, datafield: 'maritalStatus', columntype: 'textbox', filtertype: 'checkedlist', width: 200 },
                  { text: multiLang.MSBirthDate, datafield: 'birthDate', cellsformat: 'dd/MM/yyyy', filtertype: 'range', width: 200 },
                ],
                handlekeyboardnavigation: function(event){
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
                    if (key == 70 && event.ctrlKey) {
                    	$('#gridCustomer').jqxGrid('clearfilters');
                    	return true;
                    }
                },
            });
		};
		var handlerEvents = function() {
			$("#clearFilter").on('click', function() {
				$('#gridCustomer').jqxGrid('clearfilters');
			});
		};
		return {
			init: function() {
				initJqxElements();
				handlerEvents();
			}
		};
	})();
}
