export default function NavBar() {
    return <nav className="nav">
        <a href="/" className="site-title">Jamie's Language Learning</a>
        <ul>
            <li>
                <a href="/nouns" className="site-links">Nouns</a>
            </li>
            <li>
                <a href="/verbs" className="site-links">Verbs</a>
            </li>
        </ul>
    </nav>
}