import NavBar from "../components/navbar"
import Session from "../components/session"

function Adverbs() {

    const topics = [[{ name: "standard", id: 1 }, { name: "place", id: 2 }, { name: "quantity", id: 3 }], "adverbs"]

    return (
        <div className="adverbs" >
            <NavBar></NavBar>
            <div>
                <h4 style={{
                    display: 'flex',
                    justifyContent: 'center'
                }}>Adverb Practice</h4>
                <br></br>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Adverbs