package;

import js.Browser;
import js.html.InputElement;
import react.ReactRef;

private typedef AppState = {
    yearError:Bool,
    monthError:Bool,
    dayError:Bool
}

class App extends ReactComponent {
    private var year:String;
    private var month:String;
    private var day:String;

    private var yearElement:InputElement;
    private var monthElement:InputElement;
    private var dayElement:InputElement;

    public function new() {
        super();

        this.year = "--";
        this.month = "--";
        this.day = "--";

        this.state = { yearError: false, monthError: false, dayError: false };
        
        untyped #if haxe4 js.Syntax.code #else __js__ #end ("this.apply = this.apply.bind(this);");
    }

    private function apply():Void {
        var inputDate = new Date(Std.parseInt(yearElement.value), Std.parseInt(monthElement.value) - 1, Std.parseInt(dayElement.value), 0, 0, 0);

        if(!(yearElement == null || yearElement.value == "")
        && !(monthElement == null || monthElement.value == "")
        && !(dayElement == null || dayElement.value == "")) {
            calculateAge(inputDate);
        }

        var newState = {
            yearError: yearElement == null || yearElement.value == "",
            monthError: monthElement == null || monthElement.value == "",
            dayError: dayElement == null || dayElement.value == ""
        };

        this.setState(newState);
    }

    private function getDaysInMonth(year:Int, month:Int):Int {
        return new Date(year, month + 1, 0, 0, 0, 0).getDate();
    }

    private function calculateAge(birthDate:Date):Void {
        var currentDate = Date.now();
    
        var birthYear = birthDate.getFullYear();
        var birthMonth = birthDate.getMonth();
        var birthDay = birthDate.getDate();
    
        var currentYear = currentDate.getFullYear();
        var currentMonth = currentDate.getMonth();
        var currentDay = currentDate.getDate();
    
        var ageYears = currentYear - birthYear;
        var ageMonths = currentMonth - birthMonth;
        var ageDays = currentDay - birthDay;
    
        if (ageDays < 0) {
            ageDays += getDaysInMonth(currentYear, currentMonth - 1);
            ageMonths--;
        }
    
        if (ageMonths < 0) {
            ageMonths += 12;
            ageYears--;
        }
    
        year = Std.string(ageYears);
        month = Std.string(ageMonths);
        day = Std.string(ageDays);
    }
    
    private function setInputDay(input:InputElement):Void {
        this.dayElement = input;
    }

    private function setInputMonth(input:InputElement):Void {
        this.monthElement = input;
    }

    private function setInputYear(input:InputElement):Void {
        this.yearElement = input;
    }

    private function CTM(m:String, m2:String, m3:String, error:Bool, input:InputElement->Void):ReactElement {
        if(error) {
            return jsx('
                <div className="input-container">
                    <span className="type-m" style={{color: "hsl(0, 100%, 67%)"}}>${m2}</span>
                    <input
                        min="1"
                        ref=${ref->input(ref)}
                        placeholder=${m3}
                        type="number"
                        id="${m}"
                        style={{borderColor: "hsl(0, 100%, 67%)"}}
                    />
                    <small className="error-label">This field is required</small>
                </div>
            ');
        }

        return jsx('
            <div className="input-container">
                <span className="type-m">${m2}</span>
                <input
                    min="1"
                    ref=${ref->input(ref)}
                    placeholder=${m3}
                    type="number"
                    id="${m}"
                />
            </div>
        ');
    }

    override function render():ReactElement {
        return jsx('
            <div>
                <div className="container">
                    <div className="input-flex">
                        {CTM("day", "DAY", "DD", this.state.dayError, this.setInputDay)}
                        {CTM("month", "MONTH", "MM", this.state.monthError, this.setInputMonth)}
                        {CTM("year", "YEAR", "YY", this.state.yearError, this.setInputYear)}
                    </div>
                    <button className="submit" onClick=${function(e) { e.preventDefault(); apply(); }}>
                        <img src="./icon-arrow.svg" width="32" height="32" alt="" />
                    </button>
                    <div className="output-flex">
                        <h1><span className="output-year">${year} </span>years</h1>
                        <h1><span className="output-month">${month} </span>months</h1>
                        <h1><span className="output-day">${day} </span>days</h1>
                    </div>
                </div>
                <div className="credits">
                    <div className="promo" style={{display: "flex", justifyContent: "center", alignItems: "center"}}>
                        Mainly programmed with Haxe
                        <img className="haxe-image" src="haxe-logo.svg" alt="logo" style={{display: "block", width: "40px"}} />
                    </div>
                </div>
            </div>
        ');
    }
}