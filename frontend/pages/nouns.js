import NavBar from "../components/navbar"
import Session from "../components/session"

function Nouns() {

    const topics = [[{ name: "places", id: 1 }, { name: "travel", id: 2 }, { name: "time", id: 3 }], "nouns"]

    return (
        <div className="nouns" >
            <NavBar></NavBar>
            <div>
                <h4 style={{
                    display: 'flex',
                    justifyContent: 'center'
                }}>Nouns Practice</h4>
                <br></br>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Nouns