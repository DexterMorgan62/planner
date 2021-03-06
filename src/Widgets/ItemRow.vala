/*
* Copyright © 2019 Alain M. (https://github.com/alainm23/planner)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Alain M. <alain23@protonmail.com>
*/

public class Widgets.ItemRow : Gtk.ListBoxRow {
    public string icon_name  { get; construct; }
    public string item_name { get; construct; }

    private Gtk.Label primary_label;
    private Gtk.Label secondary_label;

    private Gtk.Revealer secondary_revealer;
    private Gtk.Revealer primary_revealer;

    private Gtk.Revealer main_revealer;

    public bool reveal_child {
        set {
            if (value) {
                margin_left = 6;
                margin_top = 6;
                margin_right = 6;
            } else {
                margin = 0;
            }

            main_revealer.reveal_child = value;
        }
        get {
            return main_revealer.reveal_child;
        }
    }

    public string primary_text {
        set {
            primary_label.label = value;
        }
        get {
            return primary_label.label;
        }
    }

    public string secondary_text {
        set {
            secondary_label.label = value;
        }
        get {
            return secondary_label.label;
        }
    }

    public bool revealer_primary_label {
        set {
            primary_revealer.reveal_child = value;
        }
    }

    public bool revealer_secondary_label {
        set {
            secondary_revealer.reveal_child = value;
        }
    }

    public ItemRow (string _name, string _icon) {
        Object (
            icon_name: _icon,
            item_name: _name,
            margin_left: 6,
            margin_top: 6,
            margin_right: 6
        );
    }

    construct {
        get_style_context ().add_class ("item-row");

        var icon = new Gtk.Image.from_icon_name (icon_name, Gtk.IconSize.LARGE_TOOLBAR);

        var title_name = new Gtk.Label (_("<b>%s</b>".printf (item_name)));
        title_name.use_markup = true;

        primary_label = new Gtk.Label (null);
        primary_label.valign = Gtk.Align.CENTER;
        primary_label.margin_end = 12;

        primary_revealer = new Gtk.Revealer ();
        primary_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        primary_revealer.valign = Gtk.Align.START;
        primary_revealer.halign = Gtk.Align.START;
        primary_revealer.add (primary_label);
        primary_revealer.reveal_child = false;

        secondary_label = new Gtk.Label (null);
        secondary_label.get_style_context ().add_class ("badge");
        secondary_label.valign = Gtk.Align.CENTER;

        secondary_revealer = new Gtk.Revealer ();
        secondary_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_RIGHT;
        secondary_revealer.valign = Gtk.Align.START;
        secondary_revealer.halign = Gtk.Align.START;
        secondary_revealer.add (secondary_label);
        secondary_revealer.reveal_child = false;

        var main_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        main_box.margin = 6;

        main_box.pack_start (icon, false, false, 0);
        main_box.pack_start (title_name, false, false, 12);
        main_box.pack_end (primary_revealer, false, false, 0);
        main_box.pack_end (secondary_revealer, false, false, 6);

        main_revealer = new Gtk.Revealer ();
        main_revealer.transition_type = Gtk.RevealerTransitionType.SLIDE_UP;
        main_revealer.add (main_box);
        main_revealer.reveal_child = true;

        add (main_revealer);
    }
}
